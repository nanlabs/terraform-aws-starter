output "vpc_id" {
  description = "value of the vpc_id output from the vpc module"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "value of the public_subnets output from the vpc module"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "value of the private_subnets output from the vpc module"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "value of the database_subnets output from the vpc module"
  value       = module.vpc.database_subnets
}

output "database_subnet_group" {
  description = "value of the database_subnet_group output from the vpc module"
  value       = module.vpc.database_subnet_group
}

output "app_subnets" {
  description = "value of the app_subnets output from the vpc module. It is an alias for the private_subnets output"
  value       = module.vpc.private_subnets
}

output "app_security_group" {
  description = "value of the app_security_group output from the vpc module"
  value       = module.app_security_group.security_group_id
}

output "default_security_group_id" {
  description = "value of the default_security_group_id output from the vpc module"
  value       = module.vpc.default_security_group_id
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}

output "ssm_parameter_vpc_id" {
  description = "name of the ssm parameter for the vpc id"
  value       = aws_ssm_parameter.vpc_id.name
}

output "ssm_parameter_public_subnets" {
  description = "name of the ssm parameter for the public subnets"
  value       = aws_ssm_parameter.public_subnets.name
}

output "ssm_parameter_private_subnets" {
  description = "name of the ssm parameter for the private subnets"
  value       = aws_ssm_parameter.private_subnets.name
}

output "ssm_parameter_database_subnets" {
  description = "name of the ssm parameter for the database subnets"
  value       = aws_ssm_parameter.database_subnets.name
}

output "ssm_parameter_app_subnets" {
  description = "name of the ssm parameter for the app subnets"
  value       = aws_ssm_parameter.app_subnets.name
}

output "ssm_parameter_app_security_group" {
  description = "name of the ssm parameter for the app security group"
  value       = aws_ssm_parameter.app_security_group.name
}
