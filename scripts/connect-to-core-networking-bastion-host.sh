#!/usr/bin/env bash

## Script to connect to an AWS Bastion host or create a tunnel through the bastion host. Usage:
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
##         --tunnel=LOCAL_PORT:REMOTE_HOST:REMOTE_PORT
##                                     Create a tunnel from LOCAL_PORT to REMOTE_PORT on REMOTE_HOST through the bastion host.
##
##         --tunnel-target-user=USER   Username for the tunnel target (optional)
##         --tunnel-target-key=KEY     Path to the SSH key file for the tunnel target (optional)

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

# Retrieve the Bastion host tag
bastion_tag="nan-${environment}-core-networking-bastion"

echo "Connecting to the bastion host for the environment: $environment"

echo "Using the following parameters:"
echo "  - Bastion tag: $bastion_tag"
echo "  - Key name: ${key_name:-bastion_key}"
echo "  - Key directory: ${key_dir:-$HOME/.ssh}"
echo "  - Bastion user: ${bastion_user:-ubuntu}"

# Display the tunnel configuration if provided
if [[ -n "$tunnel" ]]; then
    echo "  - Tunnel: $tunnel"
    if [[ -n "$tunnel_target_user" ]]; then
        echo "  - Tunnel target user: $tunnel_target_user"
    fi
    if [[ -n "$tunnel_target_key" ]]; then
        echo "  - Tunnel target key: $tunnel_target_key"
    fi
fi

# Collect arguments, excluding --environment
connect_args=()
for arg in "$@"; do
    [[ "$arg" == --environment* ]] && continue
    connect_args+=("$arg")
done

# Run the connection command
"${ROOT}/modules/bastion/scripts/connect.sh" --tag="$bastion_tag" "${connect_args[@]}"
