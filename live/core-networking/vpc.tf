variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
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
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = module.label.id
  vpc_cidr_block      = var.vpc_cidr_block
  enable_nat_gateway  = true
  single_nat_gateway  = true
  tags                = local.tags
  public_subnet_tags  = local.public_subnets_additional_tags
  private_subnet_tags = local.private_subnets_additional_tags
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
