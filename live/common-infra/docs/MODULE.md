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
| <a name="module_exampledb"></a> [exampledb](#module\_exampledb) | ../../modules/rds | n/a |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.db_instance_master_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_security_group.bastion_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_ssm_parameter.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_security_group_name"></a> [bastion\_security\_group\_name](#input\_bastion\_security\_group\_name) | The name of the bastion security group | `string` | n/a | yes |
| <a name="input_core_networking_ssm_parameter_prefix"></a> [core\_networking\_ssm\_parameter\_prefix](#input\_core\_networking\_ssm\_parameter\_prefix) | The SSM parameter prefix for core networking parameters | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `"development"` | no |
| <a name="input_example_db_master_username"></a> [example\_db\_master\_username](#input\_example\_db\_master\_username) | The username for the master DB user | `string` | `"root"` | no |
| <a name="input_example_db_name"></a> [example\_db\_name](#input\_example\_db\_name) | The name of the database to create | `string` | `"mydb"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for servers, tags, etc | `string` | `"name"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `"development"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example_db_instance_address"></a> [example\_db\_instance\_address](#output\_example\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_example_db_instance_master_user_secret_arn"></a> [example\_db\_instance\_master\_user\_secret\_arn](#output\_example\_db\_instance\_master\_user\_secret\_arn) | The ARN of the secret containing the connection details for the RDS instance |
| <a name="output_example_db_instance_master_user_secret_id"></a> [example\_db\_instance\_master\_user\_secret\_id](#output\_example\_db\_instance\_master\_user\_secret\_id) | The ID of the secret containing the connection details for the RDS instance |
| <a name="output_example_db_instance_master_user_secret_name"></a> [example\_db\_instance\_master\_user\_secret\_name](#output\_example\_db\_instance\_master\_user\_secret\_name) | The name of the secret containing the connection details for the RDS instance |
| <a name="output_example_db_instance_name"></a> [example\_db\_instance\_name](#output\_example\_db\_instance\_name) | The database name |
| <a name="output_example_db_instance_port"></a> [example\_db\_instance\_port](#output\_example\_db\_instance\_port) | The database port |
<!-- END_TF_DOCS -->