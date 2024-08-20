#!/usr/bin/env bash

## Script to generate the kubeconfig file for the EKS Cluster. Usage:
##
##     @script.name [option] ARGUMENTS...
##
## Options:
##     -h, --help                      Display this help message
##
##         --environment=ENVIRONMENT   Environment name (required. e.g. sandbox, development, qa, staging, production)
##                                     Will be used to retrieve the Bastion host tag.
##
##         --local-port=PORT           Local port to use when interacting with the EKS Cluster (default: 9444)

# -e: exit on error
set -e

# Load easy-options
ROOT="$(realpath "$(dirname "$0")"/..)"
SCRIPTS_DIR="${ROOT}/scripts"

# shellcheck disable=SC1091
. "${SCRIPTS_DIR}/easy-options/easyoptions.sh" || exit

# Validate required arguments
if [[ -z "$environment" ]]; then
    show_error "Environment name must be provided"
    exit 1
fi

# Check if direnv is installed
if ! command -v direnv &> /dev/null; then
    show_error "direnv is required to configure the .envrc file. Check the docs for installation instructions at https://direnv.net"
    exit 1
fi

KUBECONFIG_DIR="${ROOT}/.kubeconfig"
LOCAL_PORT="${local_port:-9444}"
REGION="us-west-2"
CLUSTER_NAME="nan-${environment}-services-platform-cluster"

KUBECONFIG_FILE="${KUBECONFIG_DIR}/$CLUSTER_NAME"

# Create kubeconfig directory if it doesn't exist
mkdir -p "${KUBECONFIG_DIR}"

# Generate kubeconfig
cat <<EOF > "${KUBECONFIG_FILE}"
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://localhost:${LOCAL_PORT}
  name: ${CLUSTER_NAME}-using-tunnel
contexts:
- context:
    cluster: ${CLUSTER_NAME}-using-tunnel
    user: ${CLUSTER_NAME}-using-tunnel
  name: ${CLUSTER_NAME}-using-tunnel
current-context: ${CLUSTER_NAME}-using-tunnel
kind: Config
preferences: {}
users:
- name: ${CLUSTER_NAME}-using-tunnel
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - --region
      - ${REGION}
      - eks
      - get-token
      - --cluster-name
      - ${CLUSTER_NAME}
      - --output
      - json
      command: aws
      interactiveMode: IfAvailable
      provideClusterInfo: false
EOF

# Inform the user
echo "Kubeconfig generated at ${KUBECONFIG_FILE}"

# Set up .envrc in the root of the repository
ENVRC_PATH="${ROOT}/.envrc"

if [ ! -f "${ENVRC_PATH}" ]; then
    echo "#!/usr/bin/env bash" > "${ENVRC_PATH}"
    echo "" >> "${ENVRC_PATH}"
    KUBECONFIG_FILE_RELATIVE_PATH=$(realpath --relative-to="${ROOT}" "${KUBECONFIG_FILE}")
    # shellcheck disable=SC2016
    echo 'export KUBECONFIG="$(realpath' "${KUBECONFIG_FILE_RELATIVE_PATH})\"" >> "${ENVRC_PATH}"
    direnv allow "${ROOT}"
    echo ".envrc configured in the repository root to automatically set KUBECONFIG."
else
    echo ".envrc already exists in the repository root. Make sure it sets KUBECONFIG to $(realpath "${KUBECONFIG_FILE}")."
fi

echo "To start using kubectl, ensure you have the tunnel active and run your kubectl commands."
