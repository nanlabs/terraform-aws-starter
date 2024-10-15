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
| <a name="module_app_security_group"></a> [app\_security\_group](#module\_app\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.app_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.app_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.database_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.database_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs_count"></a> [azs\_count](#input\_azs\_count) | Number of Availability Zones to use. This value is used to determine the number of public and private subnets to create. | `number` | `3` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateways for each private subnet | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | Any extra tags to assign to private subnets | `map(any)` | `{}` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Any extra tags to assign to public subnets | `map(any)` | `{}` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Use a single NAT Gateway for all private subnets | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC CIDR Block to use if creating a new VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC to use. Leave blank to create a new VPC. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_security_group"></a> [app\_security\_group](#output\_app\_security\_group) | value of the app\_security\_group output from the vpc module |
| <a name="output_app_subnets"></a> [app\_subnets](#output\_app\_subnets) | value of the app\_subnets output from the vpc module. It is an alias for the private\_subnets output |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | value of the database\_subnet\_group output from the vpc module |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | value of the database\_subnets output from the vpc module |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | value of the default\_security\_group\_id output from the vpc module |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | value of the private\_subnets output from the vpc module |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | value of the public\_subnets output from the vpc module |
| <a name="output_ssm_parameter_app_security_group"></a> [ssm\_parameter\_app\_security\_group](#output\_ssm\_parameter\_app\_security\_group) | name of the ssm parameter for the app security group |
| <a name="output_ssm_parameter_app_subnets"></a> [ssm\_parameter\_app\_subnets](#output\_ssm\_parameter\_app\_subnets) | name of the ssm parameter for the app subnets |
| <a name="output_ssm_parameter_database_subnets"></a> [ssm\_parameter\_database\_subnets](#output\_ssm\_parameter\_database\_subnets) | name of the ssm parameter for the database subnets |
| <a name="output_ssm_parameter_private_subnets"></a> [ssm\_parameter\_private\_subnets](#output\_ssm\_parameter\_private\_subnets) | name of the ssm parameter for the private subnets |
| <a name="output_ssm_parameter_public_subnets"></a> [ssm\_parameter\_public\_subnets](#output\_ssm\_parameter\_public\_subnets) | name of the ssm parameter for the public subnets |
| <a name="output_ssm_parameter_vpc_id"></a> [ssm\_parameter\_vpc\_id](#output\_ssm\_parameter\_vpc\_id) | name of the ssm parameter for the vpc id |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | value of the vpc\_cidr\_block output from the vpc module |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | value of the vpc\_id output from the vpc module |
<!-- END_TF_DOCS -->