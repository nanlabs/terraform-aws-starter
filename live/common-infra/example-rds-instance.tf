variable "example_db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "mydb"
}

variable "example_db_master_username" {
  description = "The username for the master DB user"
  type        = string
  default     = "root"
}

module "exampledb" {
  source = "../../modules/rds"

  name = "${module.label.id}-exampledb"

  vpc_id          = module.vpc.vpc_id
  db_subnet_group = module.vpc.database_subnet_group

  db_name            = var.example_db_name
  db_master_username = var.example_db_master_username
  db_port            = 5432

  allocated_storage = 20

  manage_master_user_password = true

  tags = module.label.tags
}

output "example_db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.exampledb.db_instance_address
}

output "example_db_instance_port" {
  description = "The database port"
  value       = module.exampledb.db_instance_port
}

output "example_db_instance_name" {
  description = "The database name"
  value       = module.exampledb.db_instance_name
}

output "example_db_instance_master_user_secret_arn" {
  description = "The ARN of the secret containing the connection details for the RDS instance"
  value       = module.exampledb.db_instance_master_user_secret_arn
}
