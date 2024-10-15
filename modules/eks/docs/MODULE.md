<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | cloudposse/eks-cluster/aws | 4.2.0 |
| <a name="module_eks_node_groups"></a> [eks\_node\_groups](#module\_eks\_node\_groups) | cloudposse/eks-node-group/aws | 3.0.1 |
| <a name="module_vpc_cni_eks_iam_role"></a> [vpc\_cni\_eks\_iam\_role](#module\_vpc\_cni\_eks\_iam\_role) | cloudposse/eks-iam-role/aws | 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_schedule.start_in_morning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.stop_at_night](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_iam_role_policy_attachment.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.vpc_cni_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | List of IAM principles to allow to access the EKS cluster.<br>It is recommended to use the default `user_name` because the default includes<br>the IAM role or user name and the session name for assumed roles.<br>Use when Principal ARN is not known at plan time. | <pre>list(object({<br>    principal_arn     = string<br>    user_name         = optional(string, null)<br>    kubernetes_groups = optional(list(string), null)<br>  }))</pre> | `[]` | no |
| <a name="input_access_entries_for_nodes"></a> [access\_entries\_for\_nodes](#input\_access\_entries\_for\_nodes) | Map of list of IAM roles for the EKS non-managed worker nodes.<br>The map key is the node type, either `EC2_LINUX` or `EC2_WINDOWS`,<br>and the list contains the IAM roles of the nodes of that type.<br>There is no need for or utility in creating Fargate access entries, as those<br>are always created automatically by AWS, just as with managed nodes.<br>Use when Principal ARN is not known at plan time. | `map(list(string))` | `{}` | no |
| <a name="input_access_entry_map"></a> [access\_entry\_map](#input\_access\_entry\_map) | Map of IAM Principal ARNs to access configuration.<br>Preferred over other inputs as this configuration remains stable<br>when elements are added or removed, but it requires that the Principal ARNs<br>and Policy ARNs are known at plan time.<br>Can be used along with other `access_*` inputs, but do not duplicate entries.<br>Map `access_policy_associations` keys are policy ARNs, policy<br>full name (AmazonEKSViewPolicy), or short name (View).<br>It is recommended to use the default `user_name` because the default includes<br>IAM role or user name and the session name for assumed roles.<br>As a special case in support of backwards compatibility, membership in the<br>`system:masters` group is is translated to an association with the ClusterAdmin policy.<br>In all other cases, including any `system:*` group in `kubernetes_groups` is prohibited. | <pre>map(object({<br>    # key is principal_arn<br>    user_name = optional(string)<br>    # Cannot assign "system:*" groups to IAM users, use ClusterAdmin and Admin instead<br>    kubernetes_groups = optional(list(string), [])<br>    type              = optional(string, "STANDARD")<br>    access_policy_associations = optional(map(object({<br>      # key is policy_arn or policy_name<br>      access_scope = optional(object({<br>        type       = optional(string, "cluster")<br>        namespaces = optional(list(string))<br>      }), {}) # access_scope<br>    })), {})  # access_policy_associations<br>  }))</pre> | `{}` | no |
| <a name="input_access_policy_associations"></a> [access\_policy\_associations](#input\_access\_policy\_associations) | List of AWS managed EKS access policies to associate with IAM principles.<br>Use when Principal ARN or Policy ARN is not known at plan time.<br>`policy_arn` can be the full ARN, the full name (AmazonEKSViewPolicy) or short name (View). | <pre>list(object({<br>    principal_arn = string<br>    policy_arn    = string<br>    access_scope = object({<br>      type       = optional(string, "cluster")<br>      namespaces = optional(list(string))<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_addons"></a> [addons](#input\_addons) | List of addons to be installed in the EKS cluster | <pre>list(object({<br>    addon_name                  = string<br>    addon_version               = string<br>    resolve_conflicts_on_create = optional(string)<br>    resolve_conflicts_on_update = optional(string)<br>    service_account_role_arn    = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_addons_depends_on"></a> [addons\_depends\_on](#input\_addons\_depends\_on) | List of resources that the addons depend on | `any` | `[]` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks allowed to access the cluster | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | List of security group IDs allowed to access the cluster | `list(string)` | `[]` | no |
| <a name="input_cluster_encryption_config_enabled"></a> [cluster\_encryption\_config\_enabled](#input\_cluster\_encryption\_config\_enabled) | Enable cluster encryption configuration | `bool` | `false` | no |
| <a name="input_cluster_encryption_config_kms_key_deletion_window_in_days"></a> [cluster\_encryption\_config\_kms\_key\_deletion\_window\_in\_days](#input\_cluster\_encryption\_config\_kms\_key\_deletion\_window\_in\_days) | KMS key deletion window in days for cluster encryption | `number` | `10` | no |
| <a name="input_cluster_encryption_config_kms_key_enable_key_rotation"></a> [cluster\_encryption\_config\_kms\_key\_enable\_key\_rotation](#input\_cluster\_encryption\_config\_kms\_key\_enable\_key\_rotation) | Enable KMS key rotation for cluster encryption | `bool` | `true` | no |
| <a name="input_cluster_encryption_config_kms_key_id"></a> [cluster\_encryption\_config\_kms\_key\_id](#input\_cluster\_encryption\_config\_kms\_key\_id) | KMS Key ID for cluster encryption configuration | `string` | `""` | no |
| <a name="input_cluster_encryption_config_kms_key_policy"></a> [cluster\_encryption\_config\_kms\_key\_policy](#input\_cluster\_encryption\_config\_kms\_key\_policy) | KMS key policy for cluster encryption | `string` | `""` | no |
| <a name="input_cluster_encryption_config_resources"></a> [cluster\_encryption\_config\_resources](#input\_cluster\_encryption\_config\_resources) | Resources to encrypt for cluster encryption | `list(string)` | <pre>[<br>  "secrets"<br>]</pre> | no |
| <a name="input_cluster_log_retention_period"></a> [cluster\_log\_retention\_period](#input\_cluster\_log\_retention\_period) | Number of days to retain cluster logs | `number` | `0` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | List of control plane log types to enable | `list(string)` | `[]` | no |
| <a name="input_endpoint_private_access"></a> [endpoint\_private\_access](#input\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_endpoint_public_access"></a> [endpoint\_public\_access](#input\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version for the EKS cluster | `string` | `"1.30"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the resources | `string` | n/a | yes |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | List of node groups to create in the EKS cluster | <pre>list(object({<br>    instance_types                 = list(string)<br>    min_size                       = number<br>    max_size                       = number<br>    desired_size                   = number<br>    health_check_type              = string<br>    ami_image_id                   = optional(string)<br>    start_stop_schedule_enabled    = optional(bool)<br>    start_schedule_recurrence_cron = optional(string)<br>    stop_schedule_recurrence_cron  = optional(string)<br>    kubernetes_labels              = optional(map(string))<br>    tags                           = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_oidc_provider_enabled"></a> [oidc\_provider\_enabled](#input\_oidc\_provider\_enabled) | Enable OIDC provider | `bool` | `true` | no |
| <a name="input_private_ipv6_enabled"></a> [private\_ipv6\_enabled](#input\_private\_ipv6\_enabled) | Enable IPv6 for Kubernetes network | `bool` | `false` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets in the VPC | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets in the VPC | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to deploy EKS cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the EKS cluster will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_certificate_authority_data"></a> [eks\_cluster\_certificate\_authority\_data](#output\_eks\_cluster\_certificate\_authority\_data) | The base64 encoded certificate data required to communicate with your cluster |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | The endpoint for the EKS cluster |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | The ID of the EKS cluster |
| <a name="output_eks_cluster_managed_security_group_id"></a> [eks\_cluster\_managed\_security\_group\_id](#output\_eks\_cluster\_managed\_security\_group\_id) | n/a |
| <a name="output_eks_cluster_node_group_roles_arns"></a> [eks\_cluster\_node\_group\_roles\_arns](#output\_eks\_cluster\_node\_group\_roles\_arns) | The ARNs of the IAM roles associated with the EKS cluster node groups |
| <a name="output_eks_cluster_node_group_roles_names"></a> [eks\_cluster\_node\_group\_roles\_names](#output\_eks\_cluster\_node\_group\_roles\_names) | The names of the IAM roles associated with the EKS cluster node groups |
<!-- END_TF_DOCS -->