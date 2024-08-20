output "master_username" {
  value       = local.username
  description = "Username for the master DB user."
}

output "master_password" {
  value       = local.password
  description = "password for the master DB user."
  sensitive   = true
}

output "cluster_name" {
  value       = aws_docdb_cluster.this.*.cluster_identifier
  description = "Cluster Identifier."
}

output "arn" {
  value       = aws_docdb_cluster.this.*.arn
  description = "Amazon Resource Name (ARN) of the cluster."
}

output "writer_endpoint" {
  value       = aws_docdb_cluster.this.*.endpoint
  description = "Endpoint of the DocumentDB cluster."
}

output "reader_endpoint" {
  value       = aws_docdb_cluster.this.*.reader_endpoint
  description = "A read-only endpoint of the DocumentDB cluster, automatically load-balanced across replicas."
}

output "connection_secret_name" {
  description = "The name of the AWS Secrets Manager secret created"
  value       = aws_secretsmanager_secret.secret.name
}

output "connection_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret created"
  value       = aws_secretsmanager_secret.secret.arn
}
