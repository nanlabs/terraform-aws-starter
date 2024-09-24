module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = "${var.name}-rds"

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  family               = var.db_family
  major_engine_version = var.db_major_engine_version
  instance_class       = var.db_instance_class

  storage_type          = var.db_storage_type
  storage_encrypted     = var.storage_encrypted
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name                       = var.db_name
  username                      = var.db_master_username
  password                      = var.db_master_password
  manage_master_user_password   = var.manage_master_user_password
  master_user_secret_kms_key_id = var.master_user_secret_kms_key_id
  port                          = var.db_port

  multi_az               = var.enable_multi_az
  db_subnet_group_name   = var.db_subnet_group
  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window              = var.db_maintenance_window
  backup_window                   = var.db_backup_window
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = true

  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot     = var.enable_skip_final_snapshot
  deletion_protection     = false

  publicly_accessible = var.enable_public_access

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "monitoring"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Monitoring role for ${var.name}"

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = var.tags
}
