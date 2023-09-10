# Create a random initial password for the RDS DB Instance
resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

locals {
  # if var.db_master_password is not set, use the random password
  password = var.db_master_password != "" ? var.db_master_password : random_password.rds_password.result
  username = var.db_master_username
}

resource "aws_secretsmanager_secret" "secret" {
  description = "RDS DB Instance Connection Credentials"
  name        = "${var.name}-connection-secret"
}

resource "aws_secretsmanager_secret_version" "secret" {
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = <<EOF
{
  "username": "${local.username}",
  "password": "${local.password}",
  "host": "${module.db.cluster_endpoint}",
  "port": ${module.db.cluster_port},
  "dbname" : "${var.db_name}"
}
EOF
}
