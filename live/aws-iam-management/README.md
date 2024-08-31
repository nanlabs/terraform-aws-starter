# AWS IAM Management

🏢 This directory contains the Terraform configuration for managing IAM roles and policies across our AWS accounts. It provides a ready-to-use Terraform module for secure and efficient access management.

## Features

- ✨ Comprehensive Root Terraform module for IAM management.
- 🔒 Utilization of AWS SSO for centralized user access management.
- 📜 Configured IAM roles and policies for various access levels (Admin, Read-Only, etc.).
- 📂 Modular and reusable Terraform code to ensure consistency across multiple AWS accounts.

## Prerequisites

- [Direnv](https://direnv.net/) for loading environment variables.
- [Terraform](https://www.terraform.io/downloads.html) for infrastructure provisioning.
- [TFswitch](https://tfswitch.warrensbox.com/) to switch between Terraform versions easily.

## Setup

1. **Change Directory:**

   Navigate to the directory containing the Terraform configuration:

   ```sh
   cd live/aws-iam-management
   ```

2. **Create .envrc file:**

   Create a new `.envrc` file in this directory by copying the `.envrc.example` file:

   ```sh
   cp .envrc.example .envrc
   ```

   Then, update the `.envrc` file with the values for your environment!

3. **Load Environment Variables:**

   Load the environment variables using `direnv`:

   ```sh
   direnv allow
   ```

4. **Set Terraform Version:**

   Ensure you are using the correct Terraform version:

   ```sh
   tfswitch
   ```

5. **Initialize Terraform:**

   Initialize the working directory with the required providers and modules:

   ```sh
   terraform init -backend-config="./configs/${ENVIRONMENT}-backend.tfvars"
   ```

6. **Workspace Management:**

   Select or create a new workspace tailored to your deployment environment:

   ```sh
   # Select an existing workspace
   terraform workspace select "${TF_WORKSPACE}"

   # Create a new workspace if it doesn't exist and select it
   terraform workspace new "${TF_WORKSPACE}"
   ```

## Deploy

🚀 **Deployment Instructions:**

1. **Plan Your Deployment:**

   Review and verify the deployment plan:

   ```sh
   terraform plan -var-file "./configs/${ENVIRONMENT}.tfvars" -out "${ENVIRONMENT}.tfplan"
   ```

2. **Execute the Plan:**

   Apply the planned configuration to provision the infrastructure:

   ```sh
   terraform apply "${ENVIRONMENT}.tfplan"
   ```

## Post Deployment Steps

After successfully deploying the IAM roles and policies, follow these steps to ensure everything is working as expected:

### Connecting to the AWS Management Console via SSO

To connect to the AWS Management Console using the newly configured IAM roles, follow these steps:

1. **Sign in to the AWS SSO portal:**

   Use your AWS SSO credentials to sign in to the AWS SSO portal.

2. **Select the AWS account and role:**

   Choose the appropriate AWS account and IAM role to access the AWS Management Console.

## Destroy

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file "./configs/${ENVIRONMENT}.tfvars"
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
