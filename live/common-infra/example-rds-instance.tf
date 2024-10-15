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

  vpc_id                 = data.aws_ssm_parameter.vpc_id.value
  db_subnet_group        = data.aws_ssm_parameter.database_subnet_group.value
  vpc_security_group_ids = [module.security_group.security_group_id]

  db_name            = var.example_db_name
  db_master_username = var.example_db_master_username
  db_port            = 5432

  db_instance_class = "db.t4g.small"

  allocated_storage = 20

  manage_master_user_password = true

  tags = merge(
    module.label.tags,
    {
      "Name" = "${module.label.id}-exampledb"
    }
  )
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${module.label.id}-exampledb-security-group"
  description = "Security group for ${module.label.id}-exampledb"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "RDS DB Instance access from within VPC"
      cidr_blocks = data.aws_vpc.main.cidr_block
    }
  ]

  egress_rules = ["all-all"]

  tags = merge(
    module.label.tags,
    {
      "Name" = "${module.label.id}-exampledb-security-group"
    }
  )
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

# get the id of the secret containing the connection details for the RDS instance
# and output it
data "aws_secretsmanager_secret" "db_instance_master_user" {
  arn = module.exampledb.db_instance_master_user_secret_arn
}

output "example_db_instance_master_user_secret_id" {
  description = "The ID of the secret containing the connection details for the RDS instance"
  value       = data.aws_secretsmanager_secret.db_instance_master_user.id
}

output "example_db_instance_master_user_secret_name" {
  description = "The name of the secret containing the connection details for the RDS instance"
  value       = data.aws_secretsmanager_secret.db_instance_master_user.name
}
