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
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |
| <a name="module_ec2_security_group"></a> [ec2\_security\_group](#module\_ec2\_security\_group) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_ec2messages_vpce_sg"></a> [ec2messages\_vpce\_sg](#module\_ec2messages\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_ssm_vpce_sg"></a> [ssm\_vpce\_sg](#module\_ssm\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_ssmmessages_vpce_sg"></a> [ssmmessages\_vpce\_sg](#module\_ssmmessages\_vpce\_sg) | terraform-aws-modules/security-group/aws | 4.17.1 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../../modules/vpc-endpoints | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.bastion_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ec2_instance_connect_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.bastion_host_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.bastion_host_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.bastion_host_instance_connect_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_key_pair.ec2_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_ssm_parameter.ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [tls_private_key.ec2_ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | Allow these CIDR blocks to instance | `string` | `null` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | AMI to use for the instance - will default to latest Ubuntu | `string` | `""` | no |
| <a name="input_create_vpc_endpoints"></a> [create\_vpc\_endpoints](#input\_create\_vpc\_endpoints) | Create VPC endpoints for SSM, EC2 Messages, and SSM Messages | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type/size - the default is not part of free tier! | `string` | `"t3.nano"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH key name to use for the instance | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets in which the EC2 instance is to be created. | `list(string)` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the root volume in GB | `number` | `8` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of the root volume | `string` | `"gp2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |
| <a name="input_vpc_endpoint_security_group_ids"></a> [vpc\_endpoint\_security\_group\_ids](#input\_vpc\_endpoint\_security\_group\_ids) | List of security group IDs to attach to the VPC endpoints. Will be ignored if create\_vpc\_endpoints is false. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id in which the EC2 instance is to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_ssm_parameter_ssh_key"></a> [ssm\_parameter\_ssh\_key](#output\_ssm\_parameter\_ssh\_key) | n/a |
<!-- END_TF_DOCS -->