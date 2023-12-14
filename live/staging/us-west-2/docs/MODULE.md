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
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../../modules/bastion | n/a |
| <a name="module_exampledb"></a> [exampledb](#module\_exampledb) | ../../../modules/rds | n/a |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_terraform_state_backend"></a> [terraform\_state\_backend](#module\_terraform\_state\_backend) | cloudposse/tfstate-backend/aws | 1.1.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | n/a |
| <a name="output_bastion_instance_profile"></a> [bastion\_instance\_profile](#output\_bastion\_instance\_profile) | n/a |
| <a name="output_example_db_instance_address"></a> [example\_db\_instance\_address](#output\_example\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_example_db_instance_master_user_secret_arn"></a> [example\_db\_instance\_master\_user\_secret\_arn](#output\_example\_db\_instance\_master\_user\_secret\_arn) | The ARN of the secret containing the connection details for the RDS instance |
| <a name="output_example_db_instance_name"></a> [example\_db\_instance\_name](#output\_example\_db\_instance\_name) | The database name |
| <a name="output_example_db_instance_port"></a> [example\_db\_instance\_port](#output\_example\_db\_instance\_port) | The database port |
| <a name="output_ssm_parameter_app_security_group"></a> [ssm\_parameter\_app\_security\_group](#output\_ssm\_parameter\_app\_security\_group) | name of the ssm parameter for the app security group |
| <a name="output_ssm_parameter_app_subnets"></a> [ssm\_parameter\_app\_subnets](#output\_ssm\_parameter\_app\_subnets) | name of the ssm parameter for the app subnets |
| <a name="output_ssm_parameter_bastion_ssh_key"></a> [ssm\_parameter\_bastion\_ssh\_key](#output\_ssm\_parameter\_bastion\_ssh\_key) | name of the ssm parameter for the bastion ssh key |
| <a name="output_ssm_parameter_database_subnets"></a> [ssm\_parameter\_database\_subnets](#output\_ssm\_parameter\_database\_subnets) | name of the ssm parameter for the database subnets |
| <a name="output_ssm_parameter_private_subnets"></a> [ssm\_parameter\_private\_subnets](#output\_ssm\_parameter\_private\_subnets) | name of the ssm parameter for the private subnets |
| <a name="output_ssm_parameter_public_subnets"></a> [ssm\_parameter\_public\_subnets](#output\_ssm\_parameter\_public\_subnets) | name of the ssm parameter for the public subnets |
| <a name="output_ssm_parameter_vpc_id"></a> [ssm\_parameter\_vpc\_id](#output\_ssm\_parameter\_vpc\_id) | name of the ssm parameter for the vpc id |
<!-- END_TF_DOCS -->
