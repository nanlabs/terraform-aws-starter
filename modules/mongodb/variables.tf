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

variable "project_name" {
  description = "The name of the project you want to create"
  type        = string
}

variable "org_id" {
  description = "The ID of the Atlas organization you want to create the project within"
  type        = string
}

variable "teams" {
  description = "An object that contains all the groups that should be created in the project"
  type        = map(any)
  default     = {}
}

variable "access_lists" {
  description = "An object that contains all the network white-lists that should be created in the project"
  type        = map(any)
  default     = {}
}

variable "region" {
  description = "The AWS region-name that the cluster will be deployed on"
  type        = string
}

variable "cluster_name" {
  description = "The cluster name"
  type        = string
}

variable "instance_type" {
  description = "The Atlas instance-type name"
  type        = string
}

variable "mongodb_major_ver" {
  description = "The MongoDB cluster major version"
  type        = number
}

variable "cluster_type" {
  description = "The MongoDB Atlas cluster type - SHARDED/REPLICASET/GEOSHARDED"
  type        = string
}

variable "num_shards" {
  description = "number of shards"
  type        = number
}

variable "replication_factor" {
  description = "The Number of replica set members, possible values are 3/5/7"
  type        = number
  default     = null
}

variable "backup_enabled" {
  description = "Indicating if the cluster uses Cloud Backup for backups"
  type        = bool
  default     = true
}

variable "pit_enabled" {
  description = "Indicating if the cluster uses Continuous Cloud Backup, if set to true - provider_backup must also be set to true"
  type        = bool
  default     = false
}

variable "disk_size_gb" {
  description = "Capacity,in gigabytes,of the host’s root volume"
  type        = number
  default     = null
}

variable "auto_scaling_disk_gb_enabled" {
  description = "Indicating if disk auto-scaling is enabled"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "STANDARD or PROVISIONED for IOPS higher than the default instance IOPS"
  type        = string
  default     = null
}

variable "provider_disk_iops" {
  description = "The maximum IOPS the system can perform"
  type        = number
  default     = null
}

variable "provider_encrypt_ebs_volume" {
  description = "Indicating if the AWS EBS encryption feature encrypts the server’s root volume"
  type        = bool
  default     = false
}

variable "vpc_peer" {
  description = "An object that contains all VPC peering requests from the cluster to AWS VPC's"
  type        = map(any)
  default     = {}
}

variable "provider_name" {
  description = "The cloud provider to use for the cluster"
  type        = string
  default     = null
}

variable "backing_provider_name" {
  description = "The cloud provider to use for the cluster"
  type        = string
  default     = null
}

// "database_users" is a map with the following structure:
// {
//   "username" : "",
//   "password" : "",
//   "role" : {
//     "role_name" : "",
//     "database_name" : ""
//   }
// }
variable "database_users" {
  description = "An object that contains all the database users that should be created in the project"
  type = map(object({
    username = string
    password = string
    role = object({
      role_name     = string
      database_name = string
    })
  }))
  default = {}
}
