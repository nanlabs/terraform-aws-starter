resource "aws_docdb_cluster" "this" {
  cluster_identifier              = var.db_name
  master_username                 = local.username
  master_password                 = local.password
  backup_retention_period         = var.retention_period
  preferred_backup_window         = var.preferred_backup_window
  final_snapshot_identifier       = lower(var.db_name)
  skip_final_snapshot             = var.skip_final_snapshot
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_id
  snapshot_identifier             = var.snapshot_identifier
  vpc_security_group_ids          = [module.security_group.security_group_id]
  db_subnet_group_name            = var.subnet_group
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = var.tags
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.cluster_size
  identifier         = "${var.name}-${var.db_name}-${count.index + 1}"
  cluster_identifier = join("", aws_docdb_cluster.this.*.id)
  apply_immediately  = var.apply_immediately
  instance_class     = var.instance_class
  tags               = var.tags
  engine             = var.engine
}

# https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html
resource "aws_docdb_cluster_parameter_group" "this" {
  name        = "${var.name}-${var.db_name}-parameter-group"
  description = "DB cluster parameter group."
  family      = var.cluster_family
  parameter {
    name  = "tls"
    value = var.tls_enabled ? "enabled" : "disabled"
  }
  tags = var.tags
}
