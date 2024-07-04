# VPC Endpoints

Terraform module to create VPC endpoints in an existing VPC.

## Usage

```hcl
module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  vpc_endpoints = {
    s3 = {
      service             = "s3"
      service_type        = "Gateway"
      route_table_ids     = module.vpc.public_route_table_ids
      policy              = null
      tags                = { Name = "s3-vpc-endpoint" }
    },
    ec2 = {
      service             = "ec2"
      service_type        = "Interface"
      security_group_ids  = [module.vpc.default_security_group_id]
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = null
      tags                = { Name = "ec2-vpc-endpoint" }
    }
  }

  security_group_ids = [module.vpc.default_security_group_id]
  tags               = { Environment = "dev" }
}

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
