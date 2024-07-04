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

### Connecting to the Bastion Host Using Session Manager

AWS Session Manager provides secure and auditable instance management without needing to open inbound ports, manage SSH keys, or use bastion hosts.

#### Prerequisites

Ensure the following prerequisites are met:

1. **SSM Agent**: Ensure the SSM agent is installed and running on your instance. For Amazon Linux, the SSM agent is pre-installed.
2. **IAM Role**: The instance must have an IAM role attached with the necessary permissions for AWS Systems Manager. Typically, this includes the `AmazonSSMManagedInstanceCore` policy.
3. **Session Manager Plugin**: Ensure the Session Manager Plugin is installed on your local machine. Check the [AWS Session Manager Plugin Installation Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) for more information.

#### Obtain Required Information

First, gather the necessary information:

- Bastion Instance ID

You can retrieve this value using Terraform:

```bash
bastion_instance_id=$(terraform output -json | jq -r '.bastion_instance_id.value')
```

#### Start a Session with the Bastion Host

Use AWS Session Manager to start a session with your instance:

```bash
aws ssm start-session --target "$bastion_instance_id"
```

This command will open a new session in your terminal, allowing you to interact with your instance securely.

### Additional Useful Commands

#### List Active Sessions

To list all active sessions:

```bash
aws ssm describe-sessions --state "Active"
```

#### Terminate a Session

To terminate a specific session, you need the session ID. First, list the active sessions to get the session ID:

```bash
aws ssm describe-sessions --state "Active"
```

Then terminate the session using the session ID:

```bash
aws ssm terminate-session --session-id <session-id>
```

### Example Script for Complete Workflow

Here's a complete example script to retrieve the VPC ID, Bastion instance ID, and start a Session Manager session:

```bash
# Retrieve VPC ID from Parameter Store
vpc_id_parameter_name=$(terraform output -json | jq -r '.ssm_parameter_vpc_id.value')
vpc_id=$(aws ssm get-parameter --name "$vpc_id_parameter_name" --query 'Parameter.Value' --output text)
echo "VPC ID: $vpc_id"

# Retrieve Bastion instance ID
bastion_instance_id=$(terraform output -json | jq -r '.bastion_instance_id.value')
echo "Bastion Instance ID: $bastion_instance_id"

# Start Session Manager session with Bastion Host
aws ssm start-session --target "$bastion_instance_id"
```

This approach leverages AWS Session Manager for secure and easy access to your instances, removing the need for SSH keys and open inbound ports. If you have any further questions or need additional assistance, please let me know!

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
