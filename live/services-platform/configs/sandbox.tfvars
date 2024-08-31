# General settings

region      = "us-west-2"
name        = "services-platform"
namespace   = "nan"
environment = "sandbox"
tags = {
}

# Core Networking settings

core_networking_ssm_parameter_prefix = "/nan-sandbox-core-networking"
bastion_security_group_name          = "nan-sandbox-core-networking-bastion-ec2-20240709184223546200000004"

# EKS settings

kubernetes_version    = "1.30"
oidc_provider_enabled = true

addons = [
  {
    addon_name    = "kube-proxy"
    addon_version = "v1.30.0-eksbuild.3"
  },
  {
    addon_name    = "coredns"
    addon_version = "v1.11.1-eksbuild.9"
  },
  {
    addon_name    = "aws-ebs-csi-driver"
    addon_version = "v1.32.0-eksbuild.1"
  }
]

node_groups = [
  {
    instance_types                 = ["t3.xlarge"]
    min_size                       = 1
    max_size                       = 1
    desired_size                   = 1
    health_check_type              = "EC2"
    start_stop_schedule_enabled    = true
    start_schedule_recurrence_cron = "0 13 * * 1-5" # 8 AM EST (1 PM UTC), weekdays
    stop_schedule_recurrence_cron  = "0 1 * * *"    # 8 PM EST (1 AM UTC)
    kubernetes_labels = {
      "environment" = "sandbox"
      "tier"        = "frontend"
    }
  },
  {
    instance_types                 = ["t3.xlarge"]
    min_size                       = 1
    max_size                       = 1
    desired_size                   = 1
    health_check_type              = "EC2"
    start_stop_schedule_enabled    = true
    start_schedule_recurrence_cron = "0 13 * * 1-5" # 8 AM EST (1 PM UTC), weekdays
    stop_schedule_recurrence_cron  = "0 1 * * *"    # 8 PM EST (1 AM UTC)
    kubernetes_labels = {
      "environment" = "sandbox"
      "tier"        = "backend"
    }
  }
]

private_ipv6_enabled                                      = false
enabled_cluster_log_types                                 = ["api"]
cluster_log_retention_period                              = 30
cluster_encryption_config_enabled                         = false
cluster_encryption_config_kms_key_id                      = ""
cluster_encryption_config_kms_key_enable_key_rotation     = false
cluster_encryption_config_kms_key_deletion_window_in_days = 10
cluster_encryption_config_kms_key_policy                  = ""
cluster_encryption_config_resources                       = ["secrets"]
namespaces                                                = []
