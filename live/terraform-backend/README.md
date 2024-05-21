# Terraform S3 Backend Configuration

🔒 This directory contains the Terraform configuration for setting up and managing the S3 backend used for storing the state of our cloud infrastructure securely.

## Features

- ✨ Utilization of the [cloudposse/tfstate-backend/aws](https://github.com/cloudposse/terraform-aws-tfstate-backend) module for robust backend setup.
- 🗄️ Secure storage of Terraform state in an S3 bucket.
- 🔒 DynamoDB table for state locking to prevent concurrent state modifications.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- Proper AWS credentials configured that can access the necessary resources.
- [TFswitch](https://tfswitch.warrensbox.com/) for managing Terraform versions.

## Setup

1. **Initialize Terraform:**

   Initialize the Terraform working directory which will download the necessary providers and modules:

   ```sh
   terraform init
   ```

## Deploy

1. **Plan the Deployment:**

   Generate an execution plan for Terraform:

   ```sh
   terraform plan -var-file ./configs/common-infra.tfvars -out ./terraform-backend.tfplan
   ```

2. **Apply the Configuration:**

   Apply the configuration to set up the S3 bucket and DynamoDB table:

   ```sh
   terraform apply "./terraform-backend.tfplan"
   ```

   🚀 **NOTE:** Confirm the actions before proceeding to ensure that the correct resources are being created or modified.

### First Time Deployment?

If this is your first deployment, Terraform will prompt you to confirm the setup of the backend. This is a critical step as it involves creating resources that will handle your Terraform state.

- **Initiate Backend Transfer:**

  If migrating from a local state, use the following command to migrate the state to the S3 bucket safely:

  ```sh
  terraform init -force-copy
  ```

  Push the changes to your version control system:

  ```sh
  git add s3-backend.tf && git commit -m "Setup Terraform S3 backend"
  git push
  ```

## Destroy

To remove the backend infrastructure, you can run the following command. Be cautious as this will remove the S3 bucket and the DynamoDB table used for state locking:

```sh
terraform destroy
```

## Additional Notes

- **Security Best Practices:** Ensure that the S3 bucket and DynamoDB table have strict access policies to protect your state files.
- **Documentation:** Keep documentation up to date and ensure all team members are aware of the backend configurations and how to handle state files securely.
