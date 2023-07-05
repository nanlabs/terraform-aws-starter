# Core Infrastructure

This is where we keep our infrastructure as code for our cloud infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)

## Initialize

```sh
terraform init
```

## 🚀 Deploy

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.
> You can change these values to match your environment and region.

```sh
terraform plan -var-file ./configs/staging.us-west-2.tfvars -out ./staging.tfplan
terraform apply ./staging.tfplan
```

## 💣 Destroy

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.
> You can change these values to match your environment and region.

```sh
terraform destroy -var-file ./configs/staging.us-west-2.tfvars
```

## Post Deployment

We have a few steps to test our deployment after it has been deployed.
Since we use Parameter Store to store some relevant information and AWS Secrets Manager to store the connection information for our database, we need to make sure that these are working as expected.

Also we need to make sure that we can access to the created Bastion Host and that we can connect to the database
from there.

> NOTE: In this example, we are using the `staging` environment and the `us-west-2` region.

### Connecting to the Bastion Host

```sh
# Get SSH Command from the terraform output
ssh_command=$(terraform output -json | jq -r '.bastion_ssh_command.value')
# Execute the SSH Command
eval $ssh_command
```
