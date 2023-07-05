# VPC

Terraform module to bootstrap a VPC for use with our shared infrastructure.

## Usage

```hcl
module "vpc" {
  source = "../../modules/vpc"
  region = "us-west-2"

  name = "shared-vpc"

  vpc_cidr_block = "10.0.0.0/16"
}
```

## Inputs

| Name           | Description                                 |        Default        | Required |
| :------------- | :------------------------------------------ | :-------------------: | :------: |
| name           | Name to use for resources, tags, etc        |          ""           |          |
| tags           | Any extra tags to assign to objects         |          {}           |          |
| vpc_id         | VPC in case you want to use an existing one | will create a new VPC |          |
| vpc_cidr_block | VPC CIDR block                              |      10.0.0.0/16      |          |

## Outputs

| Name                                | Description                             |
| :---------------------------------- | :-------------------------------------- |
| vpc_id                              | VPC ID for instance                     |
| public_subnets                      | List of public subnets                  |
| private_subnets                     | List of private subnets                 |
| database_subnets                    | List of database subnets                |
| database_subnet_group               | Database subnet group                   |
| app_subnets                         | List of app subnets                     |
| app_security_group                  | Security group for app instances        |
| ssm_parameter_vpc_id                | SSM Parameter for VPC ID                |
| ssm_parameter_public_subnets        | SSM Parameter for public subnets        |
| ssm_parameter_private_subnets       | SSM Parameter for private subnets       |
| ssm_parameter_app_subnets           | SSM Parameter for app subnets           |
| ssm_parameter_app_security_group    | SSM Parameter for app security group    |
| ssm_parameter_database_subnets      | SSM Parameter for database subnets      |
| ssm_parameter_database_subnet_group | SSM Parameter for database subnet group |
