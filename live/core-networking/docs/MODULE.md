<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../../modules/bastion | n/a |
| <a name="module_ec2messages_vpce_sg"></a> [ec2messages\_vpce\_sg](#module\_ec2messages\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_label"></a> [label](#module\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ssm_vpce_sg"></a> [ssm\_vpce\_sg](#module\_ssm\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_ssmmessages_vpce_sg"></a> [ssmmessages\_vpce\_sg](#module\_ssmmessages\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/vpc-endpoints | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_bastion"></a> [enable\_bastion](#input\_enable\_bastion) | Enable bastion host | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `"development"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for servers, tags, etc | `string` | `"name"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `"development"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-west-2"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | n/a |
| <a name="output_bastion_instance_profile"></a> [bastion\_instance\_profile](#output\_bastion\_instance\_profile) | n/a |
| <a name="output_ssm_parameter_app_security_group"></a> [ssm\_parameter\_app\_security\_group](#output\_ssm\_parameter\_app\_security\_group) | name of the ssm parameter for the app security group |
| <a name="output_ssm_parameter_app_subnets"></a> [ssm\_parameter\_app\_subnets](#output\_ssm\_parameter\_app\_subnets) | name of the ssm parameter for the app subnets |
| <a name="output_ssm_parameter_bastion_ssh_key"></a> [ssm\_parameter\_bastion\_ssh\_key](#output\_ssm\_parameter\_bastion\_ssh\_key) | name of the ssm parameter for the bastion ssh key |
| <a name="output_ssm_parameter_database_subnets"></a> [ssm\_parameter\_database\_subnets](#output\_ssm\_parameter\_database\_subnets) | name of the ssm parameter for the database subnets |
| <a name="output_ssm_parameter_private_subnets"></a> [ssm\_parameter\_private\_subnets](#output\_ssm\_parameter\_private\_subnets) | name of the ssm parameter for the private subnets |
| <a name="output_ssm_parameter_public_subnets"></a> [ssm\_parameter\_public\_subnets](#output\_ssm\_parameter\_public\_subnets) | name of the ssm parameter for the public subnets |
| <a name="output_ssm_parameter_vpc_id"></a> [ssm\_parameter\_vpc\_id](#output\_ssm\_parameter\_vpc\_id) | name of the ssm parameter for the vpc id |
<!-- END_TF_DOCS -->