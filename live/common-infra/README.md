# Common Infrastructure

🏢 This directory contains the Terraform configuration for our core cloud infrastructure. It provides a ready-to-use Terraform module with essential services and security features.

## Features

- ✨ Comprehensive Root Terraform module for quick deployment.
- 🗄️ Configured to use an external S3 bucket for Terraform state management with a DynamoDB table for state locking.
- 🐘 RDS Postgres setup for reliable database services.
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

2. **Initialize Terraform:**

   Initialize the working directory with the required providers and modules:

   ```sh
   terraform init -backend-config="./configs/prod-backend.tfvars"
   ```

3. **Workspace Management:**

   Select or create a new workspace tailored to your deployment environment:

   ```sh
   # Select an existing workspace
   terraform workspace select prod

   # Create a new workspace if it doesn't exist
   # and select it
   terraform workspace new prod
   terraform workspace select prod
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

### Connecting to the Bastion Host Using Session Manager

AWS Session Manager provides secure and auditable instance management without needing to open inbound ports, manage SSH keys, or use bastion hosts. To connect to the bastion host using Session Manager, follow these steps:

#### Follow the Connection Steps

You can check the Bastion Host Module documentation for detailed steps on connecting to the bastion host using Session Manager: [Connect to Bastion Host Using Session Manager](../../modules/bastion/README.md#connecting-to-the-bastion-host-using-session-manager).

### Connecting to the Database

To connect to the database from the bastion host, retrieve the connection information from AWS Secrets Manager. Follow these steps:

- Outside the bastion host:

```bash
db_host=$(terraform output -json | jq -r '.example_db_instance_address.value')
db_port=$(terraform output -json | jq -r '.example_db_instance_port.value')
db_name=$(terraform output -json | jq -r '.example_db_instance_name.value')

# Retrieve the parameter value from the AWS Parameter Store
SECRET_ID=$(terraform output -json | jq -r '.example_db_instance_master_user_secret_arn.value')

# Print the values
echo "DB Host: $db_host"
echo "DB Port: $db_port"
echo "DB Name: $db_name"
echo "Secret ID: $SECRET_ID"
```

- Inside the bastion host:

```bash
# Retrieve the connection information from AWS Secrets Manager
db_secret=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ID" \
  --query 'SecretString' --output json)

# Parse the connection information to obtain the username, password, host, port, and database name
db_username=$(echo $db_secret | jq -r '.username')
db_password=$(echo $db_secret | jq -r '.password')

# Connect to the database using Psql with Docker
docker run -it --rm postgres:14.0-alpine psql -h $db_host -p $db_port -U $db_username -d $db_name
```

You can now execute SQL commands to test the database setup. For example:

- Retrieve the current date and time:

```sql
> SELECT NOW();
```

- Check the database version:

```sql
> SELECT version();
```

- List the tables in the database:

```sql
> SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```

These steps will help you verify the successful setup of the database and ensure that the necessary connections and configurations are in place.

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
