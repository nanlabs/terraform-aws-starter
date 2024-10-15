variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.21"
}

variable "oidc_provider_enabled" {
  description = "Enable OIDC provider"
  type        = bool
  default     = true
}

variable "addons" {
  description = "List of addons to be installed in the EKS cluster"
  type = list(object({
    addon_name                  = string
    addon_version               = string
    resolve_conflicts_on_create = optional(string)
    resolve_conflicts_on_update = optional(string)
    service_account_role_arn    = optional(string)
  }))
  default = []
}

variable "node_groups" {
  description = "List of node groups to create in the EKS cluster"
  type = list(object({
    instance_types                 = list(string)
    min_size                       = number
    max_size                       = number
    desired_size                   = number
    health_check_type              = string
    ami_image_id                   = optional(string)
    start_stop_schedule_enabled    = optional(bool)
    start_schedule_recurrence_cron = optional(string)
    stop_schedule_recurrence_cron  = optional(string)
    kubernetes_labels              = optional(map(string))
    tags                           = optional(map(string))
  }))
  default = []
}

variable "private_ipv6_enabled" {
  description = "Enable IPv6 for Kubernetes network"
  type        = bool
  default     = false
}

variable "enabled_cluster_log_types" {
  description = "List of control plane log types to enable"
  type        = list(string)
  default     = []
}

variable "cluster_log_retention_period" {
  description = "Number of days to retain cluster logs"
  type        = number
  default     = 0
}

variable "cluster_encryption_config_enabled" {
  description = "Enable cluster encryption configuration"
  type        = bool
  default     = false
}

variable "cluster_encryption_config_kms_key_id" {
  description = "KMS Key ID for cluster encryption configuration"
  type        = string
  default     = ""
}

variable "cluster_encryption_config_kms_key_enable_key_rotation" {
  description = "Enable KMS key rotation for cluster encryption"
  type        = bool
  default     = true
}

variable "cluster_encryption_config_kms_key_deletion_window_in_days" {
  description = "KMS key deletion window in days for cluster encryption"
  type        = number
  default     = 10
}

variable "cluster_encryption_config_kms_key_policy" {
  description = "KMS key policy for cluster encryption"
  type        = string
  default     = ""
}

variable "cluster_encryption_config_resources" {
  description = "Resources to encrypt for cluster encryption"
  type        = list(string)
  default     = ["secrets"]
}

data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

locals {
  addons = concat(var.addons, [
  ])
}

module "eks_cluster" {
  source = "../../modules/eks"

  region = var.region
  name   = module.label.id

  vpc_id                                                    = local.vpc_id
  private_subnets                                           = local.private_subnets
  public_subnets                                            = local.public_subnets
  kubernetes_version                                        = var.kubernetes_version
  oidc_provider_enabled                                     = var.oidc_provider_enabled
  endpoint_private_access                                   = true
  endpoint_public_access                                    = true
  private_ipv6_enabled                                      = var.private_ipv6_enabled
  enabled_cluster_log_types                                 = var.enabled_cluster_log_types
  cluster_log_retention_period                              = var.cluster_log_retention_period
  cluster_encryption_config_enabled                         = var.cluster_encryption_config_enabled
  cluster_encryption_config_kms_key_id                      = var.cluster_encryption_config_kms_key_id
  cluster_encryption_config_kms_key_enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  cluster_encryption_config_kms_key_deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  cluster_encryption_config_kms_key_policy                  = var.cluster_encryption_config_kms_key_policy
  cluster_encryption_config_resources                       = var.cluster_encryption_config_resources
  allowed_security_group_ids                                = [data.aws_security_group.bastion_security_group.id]
  allowed_cidr_blocks                                       = []

  # Enable the IAM user creating the cluster to administer it,
  # without using the bootstrap_cluster_creator_admin_permissions option,
  # as a way to test the access_entry_map feature.
  # In general, this is not recommended. Instead, you should
  # create the access_entry_map statically, with the ARNs you want to
  # have access to the cluster. We do it dynamically here just for testing purposes.
  access_entry_map = {
    (data.aws_iam_session_context.current.issuer_arn) = {
      access_policy_associations = {
        ClusterAdmin = {}
      }
    }
  }

  addons            = local.addons
  addons_depends_on = []

  node_groups = var.node_groups

  tags = module.label.tags
}

output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks_cluster.eks_cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks_cluster.eks_cluster_endpoint
}
