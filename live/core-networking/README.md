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

## Setup

1. **Set Terraform Version:**

   Ensure you are using the correct Terraform version:

   ```sh
   tfswitch
   ```

2. **Check the Terraform Backend Configuration:**

   Verify that the backend configuration is set correctly in the `configs/prod-backend.tfvars` file.

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
   terraform init -backend-config="configs/prod-backend.tfvars"
   ```

4. **Workspace Management:**

   Select or create a new workspace tailored to your deployment environment:

   ```sh
   # Switch to the another workspace or create it if it doesn't exist
   terraform workspace select -or-create prod
   ```

## Deploy

🚀 **Deployment Instructions:**

1. **Plan Your Deployment:**

   Review and verify the deployment plan:

   ```sh
   terraform plan -var-file ./configs/prod.tfvars -out prod.tfplan
   ```

2. **Execute the Plan:**

   Apply the planned configuration to provision the infrastructure:

   ```sh
   terraform apply "prod.tfplan"
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

### Connecting to the Bastion Host

To establish a secure connection with the bastion host, follow these steps:

#### Obtain Required Information

First, you need to gather some essential information:

- Bastion SSH Parameter Name
- Bastion Instance ID

You can retrieve these values using Terraform:

```bash
bastion_ssh_parameter_name=$(terraform output -json | jq -r '.ssm_parameter_bastion_ssh_key.value')
bastion_instance_id=$(terraform output -json | jq -r '.bastion_instance_id.value')
```

#### Generate .pem file with the ssh key

```bash
aws ssm get-parameter --name "$bastion_ssh_parameter_name" --with-decryption --query 'Parameter.Value' --output text > /tmp/ssh_key.pem
chmod 400 /tmp/ssh_key.pem
```

#### Retrieve bastion's public IP

```bash
bastion_public_ip=$(aws ec2 describe-instances --instance-ids "$bastion_instance_id" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text | tr '.' '-')

# Print the value
echo "Bastion IP: $bastion_public_ip"
```

#### Connect to Bastion Host

```bash
ssh -i "/tmp/ssh_key.pem" ubuntu@ec2-"$bastion_public_ip".compute.amazonaws.com
```

Ensure that you can access the database from the bastion host and verify that Docker is functioning correctly.

#### Testing Docker and Internet Access

To verify internet access and Docker functionality, execute the following commands:

```bash
# Test Internet Access
ping -c 3 google.com

# Test Docker
docker run -it --rm hello-world
```

## Destroy

💣 **NOTE:** In this example, we are using the `prod` environment and the `us-west-2` region. Modify these values according to your environment and region.

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file ./configs/prod.tfvars
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
