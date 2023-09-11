# RDS Aurora Module

Terraform module to bootstrap a RDS Aurora instances and other database resources.

## Usage

```hcl
module "db" {
  source = "../../modules/rds-aurora"

  name = "examples-rds-aurora"

  vpc_id          = "vpc-1234567890"
  db_subnet_group = "db-subnet-group-1234567890"

  db_name            = "db_name"
  db_master_username = "db_master_username"
  db_port            = 5432

  db_instance_class       = "db.serverless"
  instances = {
    one = {}
    two = {}
  }
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
