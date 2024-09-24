module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.3.1"

  name = "${var.name}-rds-aurora"

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine         = var.db_engine
  engine_mode    = var.db_engine_mode
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  instances      = var.db_instances

  serverlessv2_scaling_configuration = {
    min_capacity = 2
    max_capacity = 10
  }

  storage_type      = var.db_storage_type
  storage_encrypted = var.storage_encrypted
  allocated_storage = var.allocated_storage

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  database_name   = var.db_name
  master_username = var.db_master_username
  master_password = var.db_master_password
  port            = var.db_port

  db_subnet_group_name   = var.db_subnet_group
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_id                 = var.vpc_id

  preferred_maintenance_window    = var.db_maintenance_window
  preferred_backup_window         = var.db_backup_window
  enabled_cloudwatch_logs_exports = ["postgresql"]
  create_cloudwatch_log_group     = true

  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot     = var.enable_skip_final_snapshot
  deletion_protection     = false

  publicly_accessible = var.enable_public_access

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  manage_master_user_password = var.manage_master_user_password

  tags = var.tags
}
