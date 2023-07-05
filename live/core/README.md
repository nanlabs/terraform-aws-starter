# Core Infrastructure

This is where we keep our infrastructure as code for our cloud infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)

## Bootstrap a new environment

We have a few steps to bootstrap a new environment.

First we will create all the resources that we need. They will remain in a separate state file.

Then we will create the S3 Backend to store the state of our infrastructure.

Finally we will copy the state of our infrastructure to the S3 Backend.

> IMPORTANT: This step needs to be done only once per environment.

### First time setup

The first time that we deploy our infrastructure, we need to create the S3 Backend to store the state of our infrastructure along with the DynamoDB table to lock the state.

#### Initialize

```sh
terraform init
```

### Create and Switch to a new workspace

```sh
# Create a new workspace if it doesn't exist
terraform workspace new staging

# Switch to the new workspace
terraform workspace select staging
```

#### 🚀 Deploy

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.
> You can change these values to match your environment and region.

```sh
terraform plan -var-file ./configs/staging.us-west-2.tfvars -out ./staging.tfplan
terraform apply ./staging.tfplan
```

Then you can copy your state to the created S3 Backend.

```sh
terraform init -force-copy
```

### Update the infrastructure

From now on, you can update your infrastructure by running the following commands:

#### Initialize with the S3 Backend

```sh
terraform init
```

#### 🚀 Deploy your changes

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.

```sh
terraform plan -var-file ./configs/staging.us-west-2.tfvars -out ./staging.tfplan
terraform apply ./staging.tfplan
```

### 💣 Destroy

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.
> You can change these values to match your environment and region.

```sh
terraform destroy -var-file ./configs/staging.us-west-2.tfvars
```

## Post Deployment Steps

We have a few steps to test our deployment after it has been deployed.
Since we use Parameter Store to store some relevant information and AWS Secrets Manager to store the connection information for our database, we need to make sure that these are working as expected.

Also we need to make sure that we can access to the created Bastion Host and that we can connect to the database
from there.

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.

### Accessing the Parameter Store

We use the Parameter Store to store values such us IDs of resources that we create. For example, the ID of the VPC that we create is stored in the Parameter Store.

```sh
# Get the parameter value from the AWS Parameter Store
vpc_id_parameter_name=$(terraform output -json | jq -r '.ssm_parameter_vpc_id')
vpc_id=$(aws ssm get-parameter --name "$vpc_id_parameter_name" --query 'Parameter.Value' --output text)

# Print the value
echo $vpc_id
```

### Connecting to the Bastion Host

```sh
# Get SSH Command from the terraform output
ssh_command=$(terraform output -json | jq -r '.bastion_ssh_command.value')
# Execute the SSH Command
eval $ssh_command
```

Now we need to make sure that we can connect to the database from the Bastion Host!
Also we need to make sure that we can use Docker and access to internet from there to download the Docker image that we need to connect to the database.

#### Testing Docker and Internet Access

```sh
# Test Internet Access
ping -c 3 google.com

# Test Docker
docker run -it --rm hello-world
```

#### Connecting to the Database

From the Bastion Host, we can connect to the database by accessing the AWS Secrets Manager and getting the connection information.

```sh
# Get the connection information from the AWS Secrets Manager
db_secret=$(aws secretsmanager get-secret-value --secret-id \
  $(terraform output -json | jq -r '.db_secret_arn.value') \
  --query 'SecretString' --output json)

# Parse the connection information to get the username, password, host and port
db_username=$(echo $db_secret | jq -r '.username')
db_password=$(echo $db_secret | jq -r '.password')
db_host=$(echo $db_secret | jq -r '.host')
db_port=$(echo $db_secret | jq -r '.port')
db_name=$(echo $db_secret | jq -r '.dbname')

# Connect to the database using Psql with Docker
docker run -it --rm postgres:14.0-alpine psql -h $db_host -p $db_port -U $db_username -d $db_name
```

Then you can run some SQL commands to test the setup of the database. For example:

- Get the current date and time

```sql
> SELECT NOW();
```

- Get the database version

```sql
> SELECT version();
```

- Get the list of Tables

```sql
> SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```
