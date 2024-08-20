# Create a random initial password for the RDS Postgres
resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

locals {
  # if var.master_password is not set, use the random password
  password = var.master_password != "" ? var.master_password : random_password.rds_password.result
  username = var.master_username
}

resource "aws_secretsmanager_secret" "secret" {
  description = "DocumentDB Credentials of ${var.db_name} service"
  name        = "${var.name}/docdb-connection-secret"
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
  "engine": "${aws_docdb_cluster.this.*.engine}",
  "host": "${aws_docdb_cluster.this.*.endpoint}",
  "port": "${aws_docdb_cluster.this.*.port}",
  "dbname" : "${var.db_name}"
}
EOF
}
