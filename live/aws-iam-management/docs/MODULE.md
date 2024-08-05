<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_admin_role"></a> [admin\_role](#module\_admin\_role) | ../../modules/iam-role | n/a |
| <a name="module_developer_role"></a> [developer\_role](#module\_developer\_role) | ../../modules/iam-role | n/a |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_read_only_role"></a> [read\_only\_role](#module\_read\_only\_role) | ../../modules/iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.developer_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `"development"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for servers, tags, etc | `string` | `"name"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `"development"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_role_arn"></a> [admin\_role\_arn](#output\_admin\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_admin_role_id"></a> [admin\_role\_id](#output\_admin\_role\_id) | The stable and unique string identifying the role |
| <a name="output_admin_role_name"></a> [admin\_role\_name](#output\_admin\_role\_name) | The name of the IAM role created |
| <a name="output_developer_role_arn"></a> [developer\_role\_arn](#output\_developer\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_developer_role_id"></a> [developer\_role\_id](#output\_developer\_role\_id) | The stable and unique string identifying the role |
| <a name="output_developer_role_name"></a> [developer\_role\_name](#output\_developer\_role\_name) | The name of the IAM role created |
| <a name="output_read_only_role_arn"></a> [read\_only\_role\_arn](#output\_read\_only\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_read_only_role_id"></a> [read\_only\_role\_id](#output\_read\_only\_role\_id) | The stable and unique string identifying the role |
| <a name="output_read_only_role_name"></a> [read\_only\_role\_name](#output\_read\_only\_role\_name) | The name of the IAM role created |
<!-- END_TF_DOCS -->