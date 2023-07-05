# vpc outputs
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

# bastion outputs
output "bastion_instance_id" {
  value = module.bastion.instance_id
}

output "bastion_instance_profile" {
  value = module.bastion.instance_profile
}

output "bastion_ssh_command" {
  value = module.bastion.ssh_command
}

output "ssm_parameter_bastion_ssh_key" {
  description = "name of the ssm parameter for the bastion ssh key"
  value       = module.bastion.ssm_parameter_ssh_key
}

# rds outputs
output "example_db_connection_secret_name" {
  description = "The name of the secret containing the connection details for the RDS instance"
  value       = module.rds.connection_secret_name
}

output "example_db_connection_secret_arn" {
  description = "The ARN of the secret containing the connection details for the RDS instance"
  value       = module.rds.connection_secret_arn
}
