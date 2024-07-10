locals {
  use_existing_vpc = length(var.vpc_id) > 0 ? true : false
}

data "aws_availability_zones" "available" {}

locals {
  vpc_id = local.use_existing_vpc ? var.vpc_id : module.vpc.vpc_id
  azs    = slice(data.aws_availability_zones.available.names, 0, var.azs_count)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.name

  create_vpc = local.use_existing_vpc ? false : true

  cidr               = var.vpc_cidr_block
  create_igw         = true
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k + length(local.azs))]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k + 2 * length(local.azs))]

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_group = true
  public_subnet_tags           = var.public_subnet_tags
  private_subnet_tags          = var.private_subnet_tags

  tags = var.tags
}
