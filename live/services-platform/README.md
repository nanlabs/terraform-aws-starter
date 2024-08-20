# EKS Cluster

🏢 This directory contains the Terraform configuration for deploying EKS clusters. It provides a ready-to-use Terraform module with essential services and security features for different environments like prod, staging, qa, and sandbox.

## Features

- ✨ Comprehensive Root Terraform module for quick deployment of EKS clusters.
- 🗄️ Configured to use an external S3 bucket for Terraform state management with a DynamoDB table for state locking.
- 🔒 Utilization of AWS Secrets Manager for secure storage of secrets.
- 📈 Auto-scaling configuration for node groups.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) for infrastructure provisioning.
- [TFswitch](https://tfswitch.warrensbox.com/) to switch between Terraform versions easily.

## Setup

1. **Set Terraform Version:**

   Ensure you are using the correct Terraform version:

   ```sh
   tfswitch
   ```

2. **Initialize Terraform:**

   Initialize the working directory with the required providers and modules:

   ```sh
   terraform init -backend-config="./configs/sandbox-backend.tfvars"
   ```

3. **Workspace Management:**

   Select or create a new workspace tailored to your deployment environment:

   ```sh
   # Select an existing workspace
   terraform workspace select sandbox

   # Create a new workspace if it doesn't exist
   # and select it
   terraform workspace new sandbox
   terraform workspace select sandbox
   ```

## Deploy

🚀 **Deployment Instructions:**

1. **Plan Your Deployment:**

   Review and verify the deployment plan:

   ```sh
   terraform plan -var-file=./configs/sandbox.tfvars -out sandbox.tfplan
   ```

2. **Execute the Plan:**

   Apply the planned configuration to provision the infrastructure:

   ```sh
   terraform apply "sandbox.tfplan"
   ```

## Post Deployment Steps

After successfully deploying the infrastructure, follow these steps to test the deployment and ensure everything is working as expected.

### Connecting to the Bastion Host Using Session Manager

AWS Session Manager provides secure and auditable instance management without needing to open inbound ports, manage SSH keys, or use bastion hosts. To connect to the bastion host using Session Manager, follow these steps:

#### Follow the Connection Steps

You can check the Bastion Host Module documentation for detailed steps on connecting to the bastion host using Session Manager: [Connect to Bastion Host Using Session Manager](../../modules/bastion/README.md#connecting-to-the-bastion-host-using-session-manager).

### Accessing the EKS Cluster

To access the EKS cluster, configure your `kubectl` to use the new cluster context from the Bastion Host. Follow these steps:

1. **Get the Cluster Name:**

   Get the cluster name from the Terraform output:

   ```sh
   CLUSTER_NAME=$(terraform output -raw cluster_name)

   echo "Cluster Name: ${CLUSTER_NAME}"
   ```

2. **Update the Kubeconfig in the Bastion Host:**

   After connecting to the Bastion Host following the [Connection Steps](#connecting-to-the-bastion-host-using-session-manager), update the kubeconfig to use the new cluster context:

   ```sh
   aws eks --region us-west-2 update-kubeconfig --name <CLUSTER_NAME>
   ```

3. **Test the cluster:**

   Get the list of nodes:

   ```sh
   kubectl get nodes
   ```

## Destroy

💣 **NOTE:** In this example, we are using the `sandbox` environment. Modify these values according to your environment.

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file=./configs/sandbox.tfvars
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
