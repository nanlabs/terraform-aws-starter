# Core Infrastructure

🏢 This directory contains the infrastructure as code for our cloud infrastructure. It provides a ready-to-use Terraform module with various features. Follow the steps below to get started.

## Features

✨ Ready to use Root Terraform module!
🗄️ Store Terraform state in an S3 bucket with a DynamoDB table for locking.
🌐 VPC with public and private subnets (application and database subnets) in three availability zones.
🔒 Security groups for bastion host and database.
🔑 Bastion host to access private resources.
🐘 RDS Postgres instance and other database resources.
🔒 AWS Secrets Manager to store database credentials.
🔧 SSM Parameter Store to store parameters such as VPC ID, Subnet IDs, etc.

## Prerequisites

✔️ [Terraform](https://www.terraform.io/downloads.html)

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).

## Setup

1. Initialize the Terraform working directory:

```sh
terraform init
```

2. Switch to a workspace:

```sh
# Create a new workspace if it doesn't exist
terraform workspace new staging

# Switch to another workspace
terraform workspace select staging
```

## Deploy

🚀 **NOTE:** In this example, we are using the `staging` environment and the `us-west-2` region. Modify these values according to your environment and region.

1. Plan the deployment:

```sh
terraform plan -var-file ./configs/staging.us-west-2.tfvars -out ./staging.tfplan
```

2. Apply the deployment:

```sh
terraform apply ./staging.tfplan
```

### First Time Deployment?

If this is the first time you are deploying, a file called `s3-backend.tf` will be created. This file configures the backend for Terraform, using S3 to store the state of our infrastructure.

Run the following command to copy the state to the S3 bucket:

```sh
terraform init -force-copy
```

Push the `s3-backend.tf` file to the repository:

```sh
git add s3-backend.tf && git commit -m "Add s3-backend.tf file"
git push
```

## Destroy

💣 **NOTE:** In this example, we are using the `staging` environment and the `us-west-2` region. Modify these values according to your environment and region.

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file ./configs/staging.us-west-2.tfvars
```

## Post Deployment Steps

After deploying the infrastructure, perform the following steps to test the deployment:

### Accessing the Parameter Store

Use the Parameter Store to retrieve stored values, such as the VPC ID:

```sh
# Get the parameter value from the AWS Parameter Store
vpc_id_parameter_name=$(terraform output -json | jq -r '.ssm_parameter_vpc_id')
vpc_id=$(aws ssm get-parameter --name "$vpc_id_parameter_name" --query 'Parameter.Value' --output text)

# Print the value
echo $vpc_id
```

### Connecting to the Bastion Host

To connect to the bastion host, execute the following commands:

```sh
# Get SSH Command from the terraform output
ssh_command=$(terraform output -json | jq -r '.bastion_ssh_command.value')

# Execute the SSH Command
eval $ssh_command
```

Ensure that you can access the database from the bastion host and that Docker is working properly.

#### Testing Docker and Internet Access

To test internet access and Docker functionality, run the following commands:

```sh
# Test Internet Access
ping -c 3 google.com

# Test Docker
docker run -it --rm hello-world
```

#### Connecting to the Database

From the bastion host, you can connect to the database by accessing AWS Secrets Manager for the connection information. Run the following commands:

```sh
# Get the connection information from AWS Secrets Manager
db_secret=$(aws secretsmanager get-secret-value --secret-id \
  $(terraform output -json | jq -r '.db_secret_arn.value') \
  --query 'SecretString' --output json)

# Parse the connection information to get the username, password, host, port, and database name
db_username=$(echo $db_secret | jq -r '.username')
db_password=$(echo $db_secret | jq -r '.password')
db_host=$(echo $db_secret | jq -r '.host')
db_port=$(echo $db_secret | jq -r '.port')
db_name=$(echo $db_secret | jq -r '.dbname')

# Connect to the database using Psql with Docker
docker run -it --rm postgres:14.0-alpine psql -h $db_host -p $db_port -U $db_username -d $db_name
```

You can now run SQL commands to test the setup of the database. For example:

- Get the current date and time:

```sql
> SELECT NOW();
```

- Get the database version:

```sql
> SELECT version();
```

- Get the list of tables:

```sql
> SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```
