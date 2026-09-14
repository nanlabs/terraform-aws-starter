#tfsec:ignore:aws-rds-enable-deletion-protection
#tfsec:ignore:aws-rds-enable-performance-insights-encryption
resource "aws_db_instance" "rds" {
  identifier                    = "${var.name}-rds-instance"
  allocated_storage             = var.allocated_storage
  max_allocated_storage         = var.max_allocated_storage
  storage_type                  = var.db_storage_type
  storage_encrypted             = var.storage_encrypted
  engine                        = var.db_engine
  engine_version                = var.db_engine_version
  instance_class                = var.db_instance_class
  db_name                       = var.db_name
  username                      = var.db_master_username
  password                      = var.manage_master_user_password ? null : var.db_master_password
  manage_master_user_password   = var.manage_master_user_password
  master_user_secret_kms_key_id = var.master_user_secret_kms_key_id
  port                          = var.db_port
  publicly_accessible           = var.enable_public_access
  vpc_security_group_ids        = concat([aws_security_group.rds_sg.id], var.additional_security_group_ids)
  db_subnet_group_name          = local.db_subnet_group_name
  multi_az                      = var.enable_multi_az
  backup_retention_period       = var.db_backup_retention_period
  backup_window                 = var.db_backup_window
  maintenance_window            = var.db_instance_window
  deletion_protection           = var.deletion_protection #tfsec:ignore:aws-rds-enable-deletion-protection #tfsec:ignore:builtin.aws.rds.aws0177
  skip_final_snapshot           = var.enable_skip_final_snapshot

  iam_database_authentication_enabled = true
  performance_insights_enabled        = true
  performance_insights_kms_key_id     = var.master_user_secret_kms_key_id

  tags = merge(var.tags, {
    Name = "${var.name}-rds"
  })
}
