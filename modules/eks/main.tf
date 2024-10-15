data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

locals {
  # https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html#vpc-cni-latest-available-version
  vpc_cni_addon = {
    addon_name               = "vpc-cni"
    addon_version            = "v1.18.3-eksbuild.2"
    resolve_conflicts        = "OVERWRITE"
    service_account_role_arn = one(module.vpc_cni_eks_iam_role[*].service_account_role_arn)
    # Specify the VPC CNI addon should be deployed before compute to ensure
    # the addon is configured before data plane compute resources are created
    before_compute = true
    most_recent    = true # To ensure access to the latest settings provided
    configuration_values = jsonencode({
      env = {
        # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
        ENABLE_PREFIX_DELEGATION = "true"
        WARM_PREFIX_TARGET       = "1"
      }
    })
  }

  addons = concat(var.addons, [
    local.vpc_cni_addon
  ])
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "4.2.0"

  subnet_ids                   = concat(var.private_subnets, var.public_subnets)
  kubernetes_version           = var.kubernetes_version
  oidc_provider_enabled        = var.oidc_provider_enabled
  enabled_cluster_log_types    = var.enabled_cluster_log_types
  cluster_log_retention_period = var.cluster_log_retention_period
  endpoint_private_access      = var.endpoint_private_access
  endpoint_public_access       = var.endpoint_public_access

  cluster_encryption_config_enabled                         = var.cluster_encryption_config_enabled
  cluster_encryption_config_kms_key_id                      = var.cluster_encryption_config_kms_key_id
  cluster_encryption_config_kms_key_enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  cluster_encryption_config_kms_key_deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  cluster_encryption_config_kms_key_policy                  = var.cluster_encryption_config_kms_key_policy
  cluster_encryption_config_resources                       = var.cluster_encryption_config_resources

  addons            = local.addons
  addons_depends_on = concat(var.addons_depends_on, [module.eks_node_groups])

  access_entry_map           = var.access_entry_map
  access_entries             = var.access_entries
  access_policy_associations = var.access_policy_associations
  access_entries_for_nodes   = var.access_entries_for_nodes

  access_config = {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = false
  }

  allowed_security_group_ids = var.allowed_security_group_ids
  allowed_cidr_blocks        = var.allowed_cidr_blocks

  kubernetes_network_ipv6_enabled = var.private_ipv6_enabled

  name = var.name

  tags = var.tags
}

module "eks_node_groups" {
  source  = "cloudposse/eks-node-group/aws"
  version = "3.0.1"

  for_each = { for idx, node_group in var.node_groups : idx => node_group }

  cluster_name      = module.eks_cluster.eks_cluster_id
  subnet_ids        = [var.private_subnets[0]]
  instance_types    = each.value.instance_types
  desired_size      = each.value.desired_size
  min_size          = each.value.min_size
  max_size          = each.value.max_size
  kubernetes_labels = each.value.kubernetes_labels

  name = "${var.name}-eks-ng-${each.key}"

  tags = merge(var.tags, each.value.tags)
}

resource "aws_autoscaling_schedule" "stop_at_night" {
  for_each = { for idx, node_group in var.node_groups : idx => node_group
    if node_group.start_stop_schedule_enabled == true
  }

  scheduled_action_name  = "${each.key}-stop-at-night"
  min_size               = 0
  desired_capacity       = 0
  max_size               = 0
  recurrence             = each.value.stop_schedule_recurrence_cron
  autoscaling_group_name = module.eks_node_groups[each.key].eks_node_group_resources[0].autoscaling_groups[0].name
}

resource "aws_autoscaling_schedule" "start_in_morning" {

  for_each = { for idx, node_group in var.node_groups : idx => node_group
    if node_group.start_stop_schedule_enabled == true
  }

  scheduled_action_name  = "${each.key}-start-in-morning"
  min_size               = each.value.min_size
  desired_capacity       = each.value.desired_size
  max_size               = each.value.max_size
  recurrence             = each.value.start_schedule_recurrence_cron
  autoscaling_group_name = module.eks_node_groups[each.key].eks_node_group_resources[0].autoscaling_groups[0].name
}
