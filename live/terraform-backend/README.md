# Terraform S3 Backend Configuration

🔒 This directory contains the Terraform configuration for setting up and managing the S3 backend used for storing the state of our cloud infrastructure securely.

## Features

- ✨ Utilization of the [cloudposse/tfstate-backend/aws](https://github.com/cloudposse/terraform-aws-tfstate-backend) module for robust backend setup.
- 🗄️ Secure storage of Terraform state in an S3 bucket.
- 🔒 DynamoDB table for state locking to prevent concurrent state modifications.

## Prerequisites

- [Direnv](https://direnv.net/) for loading environment variables.
- [Terraform](https://www.terraform.io/downloads.html) for infrastructure provisioning.
- [TFswitch](https://tfswitch.warrensbox.com/) to switch between Terraform versions easily.

## Setup

1. **Change Directory:**

   Navigate to the directory containing the Terraform configuration:

   ```sh
   cd live/terraform-backend
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

   🚀 **NOTE:** Confirm the actions before proceeding to ensure that the correct resources are being created or modified.

### First Time Deployment?

If this is your first deployment, Terraform will prompt you to confirm the setup of the backend. This is a critical step as it involves creating resources that will handle your Terraform state.

- **Initiate Backend Transfer:**

  If migrating from a local state, use the following command to migrate the state to the S3 bucket safely:

  ```sh
  terraform init -backend-config="./configs/${ENVIRONMENT}-backend.tfvars" -force-copy
  ```

  Push the changes to your version control system:

  ```sh
  git add s3-backend.tf && git commit -m "Setup Terraform S3 backend"
  git push
  ```

## Destroy

To remove the backend infrastructure, you can run the following command. Be cautious as this will remove the S3 bucket and the DynamoDB table used for state locking:

```sh
terraform destroy -var-file "./configs/${ENVIRONMENT}.tfvars"
```

## Additional Notes

- **Security Best Practices:** Ensure that the S3 bucket and DynamoDB table have strict access policies to protect your state files.
- **Documentation:** Keep documentation up to date and ensure all team members are aware of the backend configurations and how to handle state files securely.
