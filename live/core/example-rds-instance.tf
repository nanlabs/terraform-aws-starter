variable "example_db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "mydb"
}

variable "example_db_master_username" {
  description = "The username for the master DB user"
  type        = string
  default     = "myuser"
}

module "exampledb" {
  source = "../../modules/rds"

  name = "${module.label.id}-exampledb"

  vpc_id          = module.vpc.vpc_id
  db_subnet_group = module.vpc.database_subnet_group

  db_name            = var.example_db_name
  db_master_username = var.example_db_master_username
  db_port            = 5432

  tags = module.label.tags
}

output "example_db_connection_secret_name" {
  description = "The name of the secret containing the connection details for the RDS instance"
  value       = module.exampledb.connection_secret_name
}

output "example_db_connection_secret_arn" {
  description = "The ARN of the secret containing the connection details for the RDS instance"
  value       = module.exampledb.connection_secret_arn
}
