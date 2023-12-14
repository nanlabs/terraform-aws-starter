module "vpc" {
  source             = "../../../../modules/vpc"
  name               = module.label.id
  vpc_cidr_block     = "10.1.0.0/16"
  tags               = module.label.tags
  enable_nat_gateway = true
  single_nat_gateway = true
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
