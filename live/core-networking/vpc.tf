variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "azs_count" {
  description = "Number of Availability Zones (and of public/private/database subnet sets) for the VPC"
  type        = number
  default     = 3
}

locals {
  # The usage of the specific kubernetes.io/cluster/* resource tags below are required
  # for EKS and Kubernetes to discover and manage networking resources
  # https://aws.amazon.com/premiumsupport/knowledge-center/eks-vpc-subnet-discovery/
  tags = merge(var.tags, { "kubernetes.io/cluster/${var.cluster_name}" = "shared" })

  # required tags to make ALB ingress work https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
  public_subnets_additional_tags = {
    "kubernetes.io/role/elb" : 1
  }
  private_subnets_additional_tags = {
    "kubernetes.io/role/internal-elb" : 1
  }

  # Same topology the former local modules/vpc wrapper computed: /24 splits
  # of the VPC CIDR, one public + one private (app) + one database subnet
  # per AZ. Kept in the stack so the migrated network keeps its CIDRs.
  azs              = slice(data.aws_availability_zones.available.names, 0, var.azs_count)
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k + length(local.azs))]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 8, k + 2 * length(local.azs))]
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "git::https://github.com/nanlabs/terraform-aws-modules.git//modules/aws-vpc?ref=v1.19.0"

  name = module.label.id
  cidr = var.vpc_cidr_block

  azs              = local.azs
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_group = true

  public_subnet_tags  = local.public_subnets_additional_tags
  private_subnet_tags = local.private_subnets_additional_tags

  tags = local.tags
}

output "ssm_parameter_vpc_id" {
  description = "name of the ssm parameter for the vpc id"
  value       = module.vpc.ssm_parameter_vpc_id
}

output "ssm_parameter_public_subnets" {
  description = "name of the ssm parameter for the public subnets"
  value       = module.vpc.ssm_parameter_public_subnets
}

output "ssm_parameter_private_subnets" {
  description = "name of the ssm parameter for the private subnets"
  value       = module.vpc.ssm_parameter_private_subnets
}

output "ssm_parameter_database_subnets" {
  description = "name of the ssm parameter for the database subnets"
  value       = module.vpc.ssm_parameter_database_subnets
}

output "ssm_parameter_app_subnets" {
  description = "name of the ssm parameter for the app subnets"
  value       = module.vpc.ssm_parameter_app_subnets
}

output "ssm_parameter_app_security_group" {
  description = "name of the ssm parameter for the app security group"
  value       = module.vpc.ssm_parameter_app_security_group
}
