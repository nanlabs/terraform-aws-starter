variable "Environment"{
    description = "Deployment environment name"
    type = string
    default = "dev"
    }

#AWS region and VPC variables
variable "aws_region" {
   description = "The AWS region to deploy resources in."
   type        = string
   default     = "us-east-1"
 }


variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

#User-provided Database variables
variable "vpc_id" {
    description = "VPC id in which to create the RDS instance"
    type = string
    }

variable "enable_multi_az" {
    description = "create RDS instance in multiple availability zones"
    type = bool
    default = false
    }

variable "db_subnet_group" {
    description = "Database subnet group to use. Leave blank to create a new one."
    type = string
    default = ""
    }

variable "db_name" {
    description = "database username"
    type = string
    default = "name"
    }

variable "db_master_username" {
    description = "Database username"
    type = string
    default = "name"
    }

variable "manage_master_user_password" {
    description = "Set to true to allow RDS to manage the master user password in secrets manager. Cannot be set if `master_password` is provided"
    type = bool
    default = true
    }

variable "master_user_secret_kms_key_id" {
    description = "The Amazon Web Services KMS key identifier is the key ID, alias ARN, or alias name for the KMS key"
    type = string
    default = null
    }

variable "db_master_password" {
    description = "Password for the master DB user. Required unless `manage_master_user_password` is set to `true` or unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database"
    type = string
    default = null
    }

variable "db_port" {
    description = "dDatabase port"
    type = number
    default = 5432
    }

variable "db_instance_class" {
    description = "The instance class to use for RDS"
    type = string
    default = "db.t4.small"
    }

variable "db_engine" {
    description = "The databse engine to be used for RDS"
    type = string
    default = "postgres"
    }

variable "db_engine_version" {
    description = "The database engine version" 
    type = string
    default = "16.3"
    }

variable "db_family" {
    description = "The family to the database engine to be used for RDS"
    type = string
    default = "postgres16"
    }

variable "major_engine_version" {
    description = "The major engine version"
    type = string
    default = "16"
    }

variable "db_storage_type" {
    description = "The strong type for RDS"
    type = string
    default = null
    }

variable "storage_encrypted" {
    description = "Enabled storage encryption"
    type = bool
    default = true
    }

variable "allocated_storage" {
    description = "String size in GB"
    type = number
    default = 20
    }

variable "max_allocated_storage" {
    description = "Preferred maintenance window."
    type = number
    default = 100
    }

variable "db_instance_window" {
    description = "Preferred maintance window"
    type = string
    default = "Mon:00:00-Mon:03:00"
    }

variable "db_backup_window" {
    description = "Preferred backup window"
    type = string
    default = "03:00-06:00"
    }

variable "db_backup_retention_period" {
    description = "Backup retention period in days"
    type = string
    default = "1"
    }

variable "enable_skip_final_snapshot" {
    description = "When DB is deleted and if this variable is false, no false snapshot will be made."
    type = bool
    default = true
    }

variable "enable_public_access" {
    description = "Enable public access for RDS."
    type = bool
    default = false
    }

variable "name" {
    description = "Name to be used for all the resources as identifier"
    type = string
    default = "app-db"
    }

variable "tags" {
    description = "Any extra tage to assign to objects"
    type = map(any)
    default = {}
    }

variable "vpc_security_group_ids" {
    description = "list of VPC security groups to associate with the RDS cluster" 
    type = list(string)
    default = []
    }

variable "additional_security_group_ids" {
    description = "Additional security group IDs to attach to the RDS instance (merged with default SG)."
    type        = list(string)
    default     = []
}