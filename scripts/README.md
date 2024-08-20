# Infra Tools Scripts 🛠️

Welcome to the **scripts/** directory, designed to house scripts that facilitate various infrastructure tasks, including connecting to AWS Bastion hosts, tunneling into EKS Clusters, and generating `kubeconfig` files for those clusters. These tools are crafted to streamline your interactions with cloud resources, ensuring both efficiency and security in your operations.

## Overview

This directory currently includes the following key scripts:

1. **`connect-to-core-networking-bastion-host.sh`**:

   - This script connects to an AWS Bastion host within a specified environment. You can use it to either establish a direct connection or create a tunnel through the bastion host to another target.

2. **`connect-to-services-platform-eks-cluster.sh`**:

   - This script is specifically designed to create a tunnel through the bastion host directly to an EKS Cluster. This tunnel is crucial for securely interacting with the EKS Cluster using `kubectl` via a local port.

3. **`generate-services-platform-eks-kubeconfig.sh`**:
   - This script generates a `kubeconfig` file tailored for the EKS Cluster in a specified environment, configured to work with a local tunnel. It also sets up an `.envrc` file in the root of the repository to automatically set the `KUBECONFIG` environment variable using `direnv`.

## Usage Instructions

For detailed information on how to use each script, including all available options, please run the script with the `--help` flag. This will provide you with comprehensive usage instructions.

### Example Usages

#### 1. `connect-to-core-networking-bastion-host.sh`

**Simple Example (Direct Connection):**

```bash
./connect-to-core-networking-bastion-host.sh --environment=sandbox
```

This command connects directly to the bastion host in the `sandbox` environment.

**Advanced Example (With Tunnel):**

```bash
./connect-to-core-networking-bastion-host.sh --environment=staging --tunnel=8080:remote.host:80
```

This command creates a tunnel from port `8080` on your local machine to port `80` on `remote.host` through the bastion host in the `staging` environment.

#### 2. `connect-to-services-platform-eks-cluster.sh`

**Example (Create Tunnel to EKS Cluster):**

```bash
./connect-to-services-platform-eks-cluster.sh --environment=sandbox
```

This command sets up a tunnel through the bastion host to the EKS Cluster in the `sandbox` environment, allowing you to use `kubectl` via `http://localhost:${tunnel_local_port}`.

#### 3. `generate-services-platform-eks-kubeconfig.sh`

**Example (Generate Kubeconfig for EKS Cluster):**

```bash
./generate-services-platform-eks-kubeconfig.sh --environment=sandbox
```

This command generates a `kubeconfig` file for the EKS Cluster in the `sandbox` environment, configured to work with a local tunnel. It also sets up an `.envrc` file in the root of the repository to automatically set the `KUBECONFIG` environment variable.

## Adding New Scripts ✨

This repository is built to be scalable and can easily accommodate new scripts. To add a new script:

1. **Create your script** in a similar format to the existing ones.
2. **Document it** within this README, including a brief description and example usage.
3. **Ensure consistency** in option flags and usage instructions for ease of use across different scripts.

## Contribution Guide

If you have improvements, fixes, or new scripts to add, feel free to submit a pull request. Ensure that your changes are well-documented and maintain the existing style and structure of this repository.
