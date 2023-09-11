# Core Infrastructure

🏢 This directory contains the infrastructure as code for our cloud infrastructure. It provides a ready-to-use Terraform module with various features. Follow the steps below to get started.

## Features

- ✨ Ready to use Root Terraform module!
- 🗄️ Store Terraform state in an S3 bucket with a DynamoDB table for locking.
- 🌐 VPC with public and private subnets (application and database subnets) in three availability zones.
- 🔒 Security groups for bastion host and database.
- 🔑 Bastion host to access private resources.
- 🐘 RDS Postgres instance and other database resources.
- 🔒 AWS Secrets Manager to store database credentials.
- 🔧 SSM Parameter Store to store parameters such as VPC ID, Subnet IDs, etc.

## Prerequisites

✔️ [Terraform](https://www.terraform.io/downloads.html)

## Setup

1. Initialize the Terraform working directory:

```sh
terraform init
```

2. Switch to a workspace:

```sh
# Switch to the another workspace or create it if it doesn't exist
terraform workspace select -or-create prod
```

## Deploy

🚀 **NOTE:** In this example, we are using the `prod` environment and the `us-west-2` region. Modify these values according to your environment and region.

1. Plan the deployment:

```sh
terraform plan -var-file ./configs/prod.us-west-2.tfvars -out ./prod.tfplan
```

2. Apply the deployment:

```sh
terraform apply ./prod.tfplan
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

💣 **NOTE:** In this example, we are using the `prod` environment and the `us-west-2` region. Modify these values according to your environment and region.

To destroy the infrastructure, run the following command:

```sh
terraform destroy -var-file ./configs/prod.us-west-2.tfvars
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
ssh -i "/tmp/ssh_key.pem" ubuntu@ec2-"$bastion_public_ip".us-west-2.compute.amazonaws.com
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

#### Connecting to the Database

To connect to the database from the bastion host, retrieve the connection information from AWS Secrets Manager. Follow these steps:

- Outside the bastion host:

```bash
# Retrieve the parameter value from the AWS Parameter Store
SECRET_ID=$(terraform output -json | jq -r '.example_db_connection_secret_arn.value')
```

- Inside the bastion host:

```bash
# Retrieve the connection information from AWS Secrets Manager
db_secret=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ID" \
  --query 'SecretString' --output json)

# Parse the connection information to obtain the username, password, host, port, and database name
db_username=$(echo $db_secret | jq -r '.username')
db_password=$(echo $db_secret | jq -r '.password')
db_host=$(echo $db_secret | jq -r '.host')
db_port=$(echo $db_secret | jq -r '.port')
db_name=$(echo $db_secret | jq -r '.dbname')

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

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running the following command from the module directory:

```sh
terraform-docs md . > ./docs/MODULE.md
```

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
