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
| <a name="module_amplify_app"></a> [amplify\_app](#module\_amplify\_app) | cloudposse/amplify-app/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.github_pat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_branch_creation_config"></a> [auto\_branch\_creation\_config](#input\_auto\_branch\_creation\_config) | The automated branch creation configuration for the Amplify app | <pre>object({<br>    basic_auth_credentials        = optional(string)<br>    build_spec                    = optional(string)<br>    enable_auto_build             = optional(bool)<br>    enable_basic_auth             = optional(bool)<br>    enable_performance_mode       = optional(bool)<br>    enable_pull_request_preview   = optional(bool)<br>    environment_variables         = optional(map(string))<br>    framework                     = optional(string)<br>    pull_request_environment_name = optional(string)<br>    stage                         = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_auto_branch_creation_patterns"></a> [auto\_branch\_creation\_patterns](#input\_auto\_branch\_creation\_patterns) | The automated branch creation glob patterns for the Amplify app | `list(string)` | `[]` | no |
| <a name="input_basic_auth_credentials"></a> [basic\_auth\_credentials](#input\_basic\_auth\_credentials) | The credentials for basic authorization for the Amplify app | `string` | `null` | no |
| <a name="input_build_spec"></a> [build\_spec](#input\_build\_spec) | The [build specification](https://docs.aws.amazon.com/amplify/latest/userguide/build-settings.html) (build spec) for the Amplify app.<br>If not provided then it will use the `amplify.yml` at the root of your project / branch. | `string` | `null` | no |
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | The custom rules to apply to the Amplify App | <pre>list(object({<br>    condition = optional(string)<br>    source    = string<br>    status    = optional(string)<br>    target    = string<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description for the Amplify app | `string` | `null` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | Amplify custom domain configurations | <pre>map(object({<br>    enable_auto_sub_domain = optional(bool, false)<br>    wait_for_verification  = optional(bool, false)<br>    sub_domain = list(object({<br>      branch_name = string<br>      prefix      = string<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_enable_auto_branch_creation"></a> [enable\_auto\_branch\_creation](#input\_enable\_auto\_branch\_creation) | Enables automated branch creation for the Amplify app | `bool` | `false` | no |
| <a name="input_enable_basic_auth"></a> [enable\_basic\_auth](#input\_enable\_basic\_auth) | Enables basic authorization for the Amplify app.<br>This will apply to all branches that are part of this app. | `bool` | `false` | no |
| <a name="input_enable_branch_auto_build"></a> [enable\_branch\_auto\_build](#input\_enable\_branch\_auto\_build) | Enables auto-building of branches for the Amplify App | `bool` | `true` | no |
| <a name="input_enable_branch_auto_deletion"></a> [enable\_branch\_auto\_deletion](#input\_enable\_branch\_auto\_deletion) | Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables for the Amplify app | `map(string)` | `{}` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | The configuration of the environments for the Amplify App | <pre>map(object({<br>    branch_name                   = optional(string)<br>    backend_enabled               = optional(bool, false)<br>    environment_name              = optional(string)<br>    deployment_artifacts          = optional(string)<br>    stack_name                    = optional(string)<br>    display_name                  = optional(string)<br>    description                   = optional(string)<br>    enable_auto_build             = optional(bool)<br>    enable_basic_auth             = optional(bool)<br>    enable_notification           = optional(bool)<br>    enable_performance_mode       = optional(bool)<br>    enable_pull_request_preview   = optional(bool)<br>    environment_variables         = optional(map(string))<br>    framework                     = optional(string)<br>    pull_request_environment_name = optional(string)<br>    stage                         = optional(string)<br>    ttl                           = optional(number)<br>    webhook_enabled               = optional(bool, false)<br>  }))</pre> | `{}` | no |
| <a name="input_github_personal_access_token_secret_path"></a> [github\_personal\_access\_token\_secret\_path](#input\_github\_personal\_access\_token\_secret\_path) | Path to the GitHub personal access token in AWS Parameter Store | `string` | n/a | yes |
| <a name="input_iam_service_role_actions"></a> [iam\_service\_role\_actions](#input\_iam\_service\_role\_actions) | List of IAM policy actions for the AWS Identity and Access Management (IAM) service role for the Amplify app.<br>If not provided, the default set of actions will be used for the role if the variable `iam_service_role_enabled` is set to `true`. | `list(string)` | `[]` | no |
| <a name="input_iam_service_role_arn"></a> [iam\_service\_role\_arn](#input\_iam\_service\_role\_arn) | The AWS Identity and Access Management (IAM) service role for the Amplify app.<br>If not provided, a new role will be created if the variable `iam_service_role_enabled` is set to `true`. | `list(string)` | `[]` | no |
| <a name="input_iam_service_role_enabled"></a> [iam\_service\_role\_enabled](#input\_iam\_service\_role\_enabled) | Flag to create the IAM service role for the Amplify app | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_oauth_token"></a> [oauth\_token](#input\_oauth\_token) | The OAuth token for a third-party source control system for the Amplify app.<br>The OAuth token is used to create a webhook and a read-only deploy key.<br>The OAuth token is not stored. | `string` | `null` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | The platform or framework for the Amplify app | `string` | `"WEB"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The repository for the Amplify app | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amplify App ARN |
| <a name="output_backend_environments"></a> [backend\_environments](#output\_backend\_environments) | Created backend environments |
| <a name="output_branch_names"></a> [branch\_names](#output\_branch\_names) | The names of the created Amplify branches |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | Amplify App domain (non-custom) |
| <a name="output_domain_associations"></a> [domain\_associations](#output\_domain\_associations) | Created domain associations |
| <a name="output_name"></a> [name](#output\_name) | Amplify App name |
| <a name="output_webhooks"></a> [webhooks](#output\_webhooks) | Created webhooks |
<!-- END_TF_DOCS -->