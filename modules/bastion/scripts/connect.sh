#!/usr/bin/env bash

## Script to connect to an AWS Bastion host or create a tunnel through the bastion host. Usage:
##
##     @script.name [option] ARGUMENTS...
##
## Options:
##     -h, --help                      Display this help message
##
##         --instance-id=INSTANCE_ID   EC2 instance ID of the Bastion host
##         --tag=TAG                   Tag to identify the Bastion host.
##                                     Will be used to retrieve the instance ID.
##                                     If not provided, instance ID must be provided.
##                                     Will be ignored if instance ID is provided.
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

# Constants
DEFAULT_SSH_KEY_NAME="bastion_key"
DEFAULT_SSH_KEY_DIR="$HOME/.ssh"
DEFAULT_BASTION_USER="ubuntu"

# Validate required arguments
if [[ -z "$tag" && -z "$instance_id" ]]; then
    show_error "Either Bastion host tag or instance ID must be provided"
    exit 1
fi

# Set default values if not provided
SSH_KEY_NAME="${key_name:-$DEFAULT_SSH_KEY_NAME}"
SSH_KEY_DIR="${key_dir:-$DEFAULT_SSH_KEY_DIR}"
SSH_KEY_PATH="$SSH_KEY_DIR/$SSH_KEY_NAME"
SSH_PUBLIC_KEY_PATH="$SSH_KEY_PATH.pub"
BASTION_USER="${bastion_user:-$DEFAULT_BASTION_USER}"

# Check if AWS CLI and Session Manager Plugin are installed
if ! command -v aws &>/dev/null; then
    echo "AWS CLI could not be found. Please install it before running this script."
    exit 1
fi

if ! command -v session-manager-plugin &>/dev/null; then
    echo "Session Manager Plugin could not be found. Please install it before running this script."
    exit 1
fi

# Generate SSH key pair if not exists
if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "Generating SSH key pair..."
    ssh-keygen -t rsa -b 2048 -f "$SSH_KEY_PATH" -N ""
fi

# Retrieve Bastion instance ID if not provided
if [[ -z "$instance_id" ]]; then
    echo "Retrieving Bastion instance ID..."
    instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$tag" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].InstanceId" --output text | head -n 1)
    if [[ -z "$instance_id" ]]; then
        echo "No Bastion host found with tag: $tag"
        exit 1
    fi
    echo "Bastion Instance ID: $instance_id"
fi

# Send SSH Public Key
echo "Sending SSH public key to Bastion host..."
aws ec2-instance-connect send-ssh-public-key --instance-id "$instance_id" --instance-os-user "$BASTION_USER" --ssh-public-key file://"$SSH_PUBLIC_KEY_PATH" >/dev/null 2>&1 &

# Connect to Bastion Host or create a tunnel using SSH through Session Manager
ssh_proxy_command_option="ProxyCommand sh -c \"aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\""

if [[ -z "$tunnel" ]]; then
    echo "Connecting to Bastion host using SSH through Session Manager..."
    ssh -i "$SSH_KEY_PATH" -o "$ssh_proxy_command_option" "$BASTION_USER@$instance_id"
    exit 0
fi

echo "Creating tunnel through Bastion host to $tunnel..."
if [[ -n "$tunnel_target_user" && -n "$tunnel_target_key" ]]; then
    tunnel_host=$(echo "$tunnel" | cut -d':' -f2)
    ssh_proxy_command_option="ProxyCommand ssh -i $tunnel_target_key -W %h:%p $tunnel_target_user@$tunnel_host"
    ssh_tunnel_proxy_command_option="ProxyCommand ssh -i $tunnel_target_key -W %h:%p $tunnel_target_user@$tunnel_host"
    echo "Tunnel established. Press Ctrl+C to close the tunnel."
    ssh -i "$SSH_KEY_PATH" -o "$ssh_proxy_command_option" -L "$tunnel" -o "$ssh_tunnel_proxy_command_option" -N "$BASTION_USER@$instance_id"
else
    echo "Tunnel established. Press Ctrl+C to close the tunnel."
    ssh -i "$SSH_KEY_PATH" -o "$ssh_proxy_command_option" -L "$tunnel" -N "$BASTION_USER@$instance_id"
fi
