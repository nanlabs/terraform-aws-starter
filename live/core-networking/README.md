# Core Networking Terraform Module

🏢 This directory contains the Terraform configuration for our core cloud infrastructure. It provides a ready-to-use Terraform module with essential services and security features.

## Features

- ✨ Comprehensive Root Terraform module for quick deployment.
- 🗄️ Configured to use an external S3 bucket for Terraform state management with a DynamoDB table for state locking.
- 🌐 Highly available VPC setup with public and private subnets across multiple availability zones.
- 🔒 Configured security groups for bastion hosts and databases.
- 🔑 Bastion host setup for secure access to internal services.
- 🔒 Utilization of AWS Secrets Manager for secure storage of database credentials.
- 🔧 Use of SSM Parameter Store for managing network and service parameters.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) for infrastructure provisioning.
- [TFswitch](https://tfswitch.warrensbox.com/) to switch between Terraform versions easily.
- AWS Session Manager Plugin for the AWS CLI.

## Setup

1. **Set Terraform Version:**

   Ensure you are using the correct Terraform version:

   ```sh
   tfswitch
   ```

2. **Check the Terraform Backend Configuration:**

   Verify that the backend configuration is set correctly in the `backend.tf` file.

   ```hcl
   terraform {
     required_version = ">= 1.0.0"

     backend "s3" {
       region         = "us-west-2"
       bucket         = "terraform-state"
       key            = "terraform.tfstate"
       dynamodb_table = "terraform-state-lock"
       profile        = ""
       encrypt        = "true"
     }
   }
   ```

   Replace the placeholder values with the actual bucket name, key, region, and DynamoDB table name.

3. **Initialize Terraform:**

   Initialize the working directory with the required providers and modules:

   ```sh
   terraform init
   ```

4. **Workspace Management:**

   Select or create a new workspace tailored to your deployment environment:

   ```sh
   # Switch to another workspace or create it if it doesn't exist
   terraform workspace select -or-create sandbox
   ```

## Deploy

🚀 **Deployment Instructions:**

1. **Plan Your Deployment:**

   Review and verify the deployment plan:

   ```sh
   terraform plan -var-file ./configs/sandbox.tfvars -out sandbox.tfplan
   ```

2. **Execute the Plan:**

   Apply the planned configuration to provision the infrastructure:

   ```sh
   terraform apply "sandbox.tfplan"
   ```

## Post Deployment Steps

After successfully deploying the infrastructure, follow these steps to test the deployment and ensure everything is working as expected:

### Accessing the Parameter Store

Retrieve stored values, such as the VPC ID, using the AWS Parameter Store:

```bash
# Retrieve the parameter value from the AWS Parameter Store
vpc_id_parameter_name=$(terraform output -json | jq -r '.ssm_parameter_vpc_id.value')
vpc_id=$(aws ssm get-parameter --name "$vpc_id_parameter_name" --query 'Parameter.Value' --output text)

# Print the value
echo "VPC ID: $vpc_id"
```

### Connecting to the Bastion Host Using Session Manager

AWS Session Manager provides secure and auditable instance management without needing to open inbound ports, manage SSH keys, or use bastion hosts. To connect to the bastion host using Session Manager, follow these steps:

#### Gather Information

Get the Bastion Instance ID from the Terraform output. You can retrieve this value using Terraform:

```bash
bastion_instance_id=$(terraform output -json | jq -r '.bastion_instance_id.value')

echo "Bastion Instance ID: $bastion_instance_id"
```

#### Follow the Connection Steps

You can check the Bastion Host Module documentation for detailed steps on connecting to the bastion host using Session Manager: [Connect to Bastion Host Using Session Manager](../../modules/bastion/README.md#connecting-to-the-bastion-host-using-session-manager).

## Destroy

💣 **NOTE:** In this example, we are using the `sandbox` environment and the `us-west-2` region. Modify these values according to your environment and region.

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file ./configs/sandbox.tfvars
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
