#!/usr/bin/env bash

## Script to create a tunnel through the bastion host to the EKS Cluster. Usage:
##
##     @script.name [option] ARGUMENTS...
##
## Options:
##     -h, --help                      Display this help message
##
##         --environment=ENVIRONMENT   Environment name (required. e.g. sandbox, development, qa, staging, production)
##                                     Will be used to retrieve the Bastion host tag.
##
##         --key-name=KEY_NAME         Name of the SSH key file (default: bastion_key)
##         --key-dir=KEY_DIR           Directory to store the SSH key (default: ~/.ssh)
##
##         --bastion-user=USER         Username for the bastion host (default: ubuntu)
##
##         --tunnel-local-port=PORT    Local port for the tunnel (default: 9444)

# -e: exit on error
set -e

ROOT="$(realpath "$(dirname "$0")"/..)"
SCRIPTS_DIR="${ROOT}/scripts"

# shellcheck disable=SC1091
. "${SCRIPTS_DIR}/easy-options/easyoptions.sh" || exit

# Check if the environment is provided
if [[ -z "$environment" ]]; then
    show_error "Environment name must be provided"
    exit 1
fi

tunnel_local_port="${tunnel_local_port:-9444}"

cluster_name="nan-${environment}-services-platform-cluster"
tunnel_remote_host="$(aws eks describe-cluster --name "$cluster_name" --query 'cluster.endpoint' --output text | sed 's/https:\/\///')"
tunnel_remote_port=443
tunnel="${tunnel_local_port}:${tunnel_remote_host}:${tunnel_remote_port}"

# Collect arguments, excluding --tunnel-local-port and --tunnel-remote-port
connect_args=()
for arg in "$@"; do
    [[ "$arg" == --tunnel-local-port* ]] && continue
    connect_args+=("$arg")
done

# Run the connection command
"${SCRIPTS_DIR}/connect-to-core-networking-bastion-host.sh" --tunnel="$tunnel" "${connect_args[@]}"
