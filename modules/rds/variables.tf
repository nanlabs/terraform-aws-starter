variable "vpc_id" {
  description = "VPC id in which the RDS instance is to be created."
  type        = string
}

variable "enable_multi_az" {
  description = "Create RDS instance in multiple availability zones."
  type        = bool
  default     = false
}

variable "db_subnet_group" {
  description = "Database subnet group to use. Leave blank to create a new one."
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "name"
}

variable "db_master_username" {
  description = "Database username"
  type        = string
  default     = "name"
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password` is provided"
  type        = bool
  default     = true
}

variable "master_user_secret_kms_key_id" {
  description = "The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key"
  type        = string
  default     = null
}

variable "db_master_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Required unless `manage_master_user_password` is set to `true` or unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database"
  type        = string
  default     = null
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "db_instance_class" {
  description = "The instance class to use for RDS."
  type        = string
  default     = "db.t4g.small"
}

variable "db_engine" {
  description = "The name of the database engine to be used for RDS."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The database engine version."
  type        = string
  default     = "16.3"
}

variable "db_family" {
  description = "The family of the database engine to be used for RDS."
  type        = string
  default     = "postgres16"
}

variable "db_major_engine_version" {
  description = "The major engine version."
  type        = string
  default     = "16"
}

variable "db_storage_type" {
  description = "Storage Type for RDS."
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Enable storage encryption."
  type        = bool
  default     = true
}

variable "allocated_storage" {
  description = "Storage size in GB."
  type        = number
  default     = null
}

variable "max_allocated_storage" {
  description = "Maximum storage size in GB."
  type        = number
  default     = null
}

variable "db_maintenance_window" {
  description = "Preferred maintenance window."
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  description = "Preferred backup window."
  type        = string
  default     = "03:00-06:00"
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days."
  type        = string
  default     = "1"
}

variable "enable_skip_final_snapshot" {
  description = "When DB is deleted and If this variable is false, no final snapshot will be made."
  type        = bool
  default     = true
}

variable "enable_public_access" {
  description = "Enable public access for RDS."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the RDS cluster"
  type        = list(string)
  default     = []
}
