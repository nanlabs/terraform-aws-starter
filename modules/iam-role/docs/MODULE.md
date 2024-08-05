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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_aggregated](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_actions"></a> [assume\_role\_actions](#input\_assume\_role\_actions) | The IAM action to be granted by the AssumeRole policy | `list(string)` | <pre>[<br>  "sts:AssumeRole",<br>  "sts:TagSession"<br>]</pre> | no |
| <a name="input_assume_role_conditions"></a> [assume\_role\_conditions](#input\_assume\_role\_conditions) | List of conditions for the assume role policy | <pre>list(object({<br>    test     = string<br>    variable = string<br>    values   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_instance_profile_enabled"></a> [instance\_profile\_enabled](#input\_instance\_profile\_enabled) | Create EC2 Instance Profile for the role | `bool` | `false` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | List of managed policies to attach to created role | `set(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to the role and policy. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) for more information. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the role | `string` | `""` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | The description of the IAM policy that is visible in the IAM policy manager | `string` | `""` | no |
| <a name="input_policy_document_count"></a> [policy\_document\_count](#input\_policy\_document\_count) | Number of policy documents (length of policy\_documents list) | `number` | `1` | no |
| <a name="input_policy_documents"></a> [policy\_documents](#input\_policy\_documents) | List of JSON IAM policy documents | `list(string)` | `[]` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the IAM policy that is visible in the IAM policy manager | `string` | `null` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`))) | `map(list(string))` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | The description of the IAM role that is visible in the IAM role manager | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_id"></a> [id](#output\_id) | The stable and unique string identifying the role |
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | Name of the ec2 profile (if enabled) |
| <a name="output_name"></a> [name](#output\_name) | The name of the IAM role created |
| <a name="output_policy"></a> [policy](#output\_policy) | Role policy document in json format. Outputs always, independent of `enabled` variable |
<!-- END_TF_DOCS -->