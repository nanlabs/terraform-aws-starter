output "cluster_arn" {
  description = "The ARN of the RDS instance"
  value       = module.db.cluster_arn
}

output "cluster_endpoint" {
  description = "The connection endpoint"
  value       = module.db.cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "The address of the RDS instance"
  value       = module.db.cluster_reader_endpoint
}

output "cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = try(module.db.cluster_members, null)
}

output "cluster_engine_version_actual" {
  description = "The running version of the database"
  value       = module.db.cluster_engine_version_actual
}

output "cluster_database_name" {
  description = "The database name"
  value       = module.db.cluster_database_name
}

output "cluster_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.db.cluster_resource_id
}

output "cluster_port" {
  description = "The database port"
  value       = module.db.cluster_port
}

output "cluster_master_username" {
  description = "The master username for the database"
  value       = module.db.cluster_master_username
  sensitive   = true
}

output "cluster_instances" {
  description = "The RDS Instances for this cluster"
  value       = module.db.cluster_instances
}

output "enhanced_monitoring_iam_role_name" {
  description = "The name of the IAM role used for enhanced monitoring"
  value       = module.db.enhanced_monitoring_iam_role_name
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The ARN of the IAM role used for enhanced monitoring"
  value       = module.db.enhanced_monitoring_iam_role_arn
}

output "enhanced_monitoring_iam_role_unique_id" {
  description = "The unique ID of the IAM role used for enhanced monitoring"
  value       = module.db.enhanced_monitoring_iam_role_unique_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.db.security_group_id
}

output "db_cluster_cloudwatch_log_groups" {
  description = "The CloudWatch log groups for the DB cluster"
  value       = module.db.db_cluster_cloudwatch_log_groups
}

output "cluster_master_user_secret" {
  description = "The AWS Secrets Manager secret created"
  value       = module.db.cluster_master_user_secret
}
