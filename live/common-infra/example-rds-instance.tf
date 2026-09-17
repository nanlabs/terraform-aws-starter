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
  source = "git::https://github.com/nanlabs/terraform-aws-modules.git//modules/aws-rds?ref=v1.18.0"

  name = "${module.label.id}-exampledb"

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "16.3"
  family               = "postgres16"
  major_engine_version = "16"
  instance_class       = "db.t4g.small"

  storage_encrypted = true
  allocated_storage = 20

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name                     = var.example_db_name
  username                    = var.example_db_master_username
  manage_master_user_password = true
  port                        = 5432

  multi_az             = false
  db_subnet_group_name = data.aws_ssm_parameter.database_subnet_group.value

  vpc_security_group_ids = [module.security_group.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  publicly_accessible = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "monitoring"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Monitoring role for ${module.label.id}-exampledb"

  parameters = [
    {
      name  = "autovacuum"
      value = "1"
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = merge(
    module.label.tags,
    {
      "Name" = "${module.label.id}-exampledb"
    }
  )
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name        = "${module.label.id}-exampledb-security-group"
  description = "Security group for ${module.label.id}-exampledb"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_rules = {
    postgres = {
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"
      description = "RDS DB Instance access from within VPC"
      cidr_ipv4   = data.aws_vpc.vpc.cidr_block
    }
  }

  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = merge(
    module.label.tags,
    {
      "Name" = "${module.label.id}-exampledb-security-group"
    }
  )
}

output "example_db_instance_address" {
  description = "The address of the RDS instance"
  # The library exposes the full endpoint (host:port); keep exposing the
  # bare hostname like the former local wrapper did.
  value = split(":", module.exampledb.db_instance_endpoint)[0]
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
