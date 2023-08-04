# VPC

Terraform module to bootstrap a VPC for use with our shared infrastructure.

## Usage

```hcl
module "vpc" {
  source = "../../modules/vpc"

  name = "shared-vpc"

  vpc_cidr_block = "10.0.0.0/16"
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
