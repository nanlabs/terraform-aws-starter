variable "region" {
  description = "The AWS region to deploy EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets in the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets in the VPC"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "name" {
  description = "Name for the resources"
  type        = string
}

variable "tags" {
  description = "Additional tags for the resources"
  type        = map(string)
  default     = {}
}

variable "oidc_provider_enabled" {
  description = "Enable OIDC provider"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
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

variable "addons_depends_on" {
  description = "List of resources that the addons depend on"
  type        = any
  default     = []
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


variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to access the cluster"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the cluster"
  type        = list(string)
  default     = []
}

variable "access_entry_map" {
  type = map(object({
    # key is principal_arn
    user_name = optional(string)
    # Cannot assign "system:*" groups to IAM users, use ClusterAdmin and Admin instead
    kubernetes_groups = optional(list(string), [])
    type              = optional(string, "STANDARD")
    access_policy_associations = optional(map(object({
      # key is policy_arn or policy_name
      access_scope = optional(object({
        type       = optional(string, "cluster")
        namespaces = optional(list(string))
      }), {}) # access_scope
    })), {})  # access_policy_associations
  }))         # access_entry_map
  description = <<-EOT
    Map of IAM Principal ARNs to access configuration.
    Preferred over other inputs as this configuration remains stable
    when elements are added or removed, but it requires that the Principal ARNs
    and Policy ARNs are known at plan time.
    Can be used along with other `access_*` inputs, but do not duplicate entries.
    Map `access_policy_associations` keys are policy ARNs, policy
    full name (AmazonEKSViewPolicy), or short name (View).
    It is recommended to use the default `user_name` because the default includes
    IAM role or user name and the session name for assumed roles.
    As a special case in support of backwards compatibility, membership in the
    `system:masters` group is is translated to an association with the ClusterAdmin policy.
    In all other cases, including any `system:*` group in `kubernetes_groups` is prohibited.
    EOT
  default     = {}
  nullable    = false
}

variable "access_entries" {
  type = list(object({
    principal_arn     = string
    user_name         = optional(string, null)
    kubernetes_groups = optional(list(string), null)
  }))
  description = <<-EOT
    List of IAM principles to allow to access the EKS cluster.
    It is recommended to use the default `user_name` because the default includes
    the IAM role or user name and the session name for assumed roles.
    Use when Principal ARN is not known at plan time.
    EOT
  default     = []
  nullable    = false
}

variable "access_policy_associations" {
  type = list(object({
    principal_arn = string
    policy_arn    = string
    access_scope = object({
      type       = optional(string, "cluster")
      namespaces = optional(list(string))
    })
  }))
  description = <<-EOT
    List of AWS managed EKS access policies to associate with IAM principles.
    Use when Principal ARN or Policy ARN is not known at plan time.
    `policy_arn` can be the full ARN, the full name (AmazonEKSViewPolicy) or short name (View).
    EOT
  default     = []
  nullable    = false
}

variable "access_entries_for_nodes" {
  # We use a map instead of an object because if a user supplies
  # an object with an unexpected key, Terraform simply ignores it,
  # leaving us with no way to detect the error.
  type        = map(list(string))
  description = <<-EOT
    Map of list of IAM roles for the EKS non-managed worker nodes.
    The map key is the node type, either `EC2_LINUX` or `EC2_WINDOWS`,
    and the list contains the IAM roles of the nodes of that type.
    There is no need for or utility in creating Fargate access entries, as those
    are always created automatically by AWS, just as with managed nodes.
    Use when Principal ARN is not known at plan time.
    EOT
  default     = {}
  nullable    = false
  validation {
    condition = length([for k in keys(var.access_entries_for_nodes) : k if !contains(["EC2_LINUX", "EC2_WINDOWS"], k)]) == 0
    error_message = format(<<-EOS
      The access_entries_for_nodes object can only contain the EC2_LINUX and EC2_WINDOWS attributes:
      Keys "%s" not allowed.
      EOS
    , join("\", \"", [for k in keys(var.access_entries_for_nodes) : k if !contains(["EC2_LINUX", "EC2_WINDOWS"], k)]))
  }
  validation {
    condition     = !(contains(keys(var.access_entries_for_nodes), "FARGATE_LINUX"))
    error_message = <<-EOM
      Access entries of type "FARGATE_LINUX" are not supported because they are
      automatically created by AWS EKS and should not be managed by Terraform.
      EOM
  }
}
