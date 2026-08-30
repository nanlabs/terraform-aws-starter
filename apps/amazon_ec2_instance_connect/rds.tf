resource "aws_db_instance" "rds" {
    identifier                      = "${var.name}-rds-instance"
    allocated_storage               = var.allocated_storage
    max_allocated_storage           = var.max_allocated_storage
    storage_type                    = var.db_storage_type
    storage_encrypted               = var.storage_encrypted
    engine                          = var.db_engine
    engine_version                  = var.db_engine_version
    instance_class                  = var.db_instance_class
    db_name                         = var.db_name
    username                        = var.db_master_username
    password                        = var.manage_master_user_password ? null : var.db_master_password
    manage_master_user_password     = var.manage_master_user_password
    master_user_secret_kms_key_id   = var.master_user_secret_kms_key_id
    port                            = var.db_port
    multi_az                        = var.enable_multi_az

    db_subnet_group_name            = local.target_db_subnet_group
    vpc_security_group_ids          = concat([aws_security_group.rds_sg.id], var.additional_security_group_ids) 

    maintenance_window              = var.db_instance_window
    backup_window                   = var.db_backup_window
    backup_retention_period         = var.db_backup_retention_period
    skip_final_snapshot             = var.enable_skip_final_snapshot
    final_snapshot_identifier       = var.enable_skip_final_snapshot ? null : "${var.name_prefix}-final-snapshot"
    deletion_protection             = var.deletion_protection
    publicly_accessible             = var.enable_public_access

    tags = merge(var.tags, {
        Name = "${var.name}-db"
        })
}
