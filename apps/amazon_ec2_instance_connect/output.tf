output "rds_endpoint" {
    description = "The connection endpoint of the RDS instance"
    value = aws_db_instance.rds.endpoint
}

output "rds_address" {
    description = "The address of the RDS instance"
    value = aws_db_instance.rds.address
}

output "rds_port" { 
    description = "The database port"
    value = aws_db_instance.rds.port
}

output "eic_endpoint_id" {
  description = "The ID of the EC2 Instance Connect Endpoint"
  value       = aws_ec2_instance_connect_endpoint.eic.id
}

output "master_user_secret_arn" {
  description = "ARN of the Secret Manager secret for master password (if managed by AWS)"
  value       = var.manage_master_user_password ? aws_db_instance.rds.master_user_secret[0].secret_arn : null
}

