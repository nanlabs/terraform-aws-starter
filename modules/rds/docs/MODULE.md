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
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | 6.1.1 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.address](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.master_user_secret_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Storage size in GB. | `number` | `null` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | Backup retention period in days. | `string` | `"1"` | no |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | Preferred backup window. | `string` | `"03:00-06:00"` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | The name of the database engine to be used for RDS. | `string` | `"postgres"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | The database engine version. | `string` | `"16.3"` | no |
| <a name="input_db_family"></a> [db\_family](#input\_db\_family) | The family of the database engine to be used for RDS. | `string` | `"postgres16"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class to use for RDS. | `string` | `"db.t4g.small"` | no |
| <a name="input_db_maintenance_window"></a> [db\_maintenance\_window](#input\_db\_maintenance\_window) | Preferred maintenance window. | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_db_major_engine_version"></a> [db\_major\_engine\_version](#input\_db\_major\_engine\_version) | The major engine version. | `string` | `"16"` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Required unless `manage_master_user_password` is set to `true` or unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database | `string` | `null` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | Database username | `string` | `"name"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | `"name"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port | `number` | `5432` | no |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | Storage Type for RDS. | `string` | `null` | no |
| <a name="input_db_subnet_group"></a> [db\_subnet\_group](#input\_db\_subnet\_group) | Database subnet group to use. Leave blank to create a new one. | `string` | `""` | no |
| <a name="input_enable_multi_az"></a> [enable\_multi\_az](#input\_enable\_multi\_az) | Create RDS instance in multiple availability zones. | `bool` | `false` | no |
| <a name="input_enable_public_access"></a> [enable\_public\_access](#input\_enable\_public\_access) | Enable public access for RDS. | `bool` | `true` | no |
| <a name="input_enable_skip_final_snapshot"></a> [enable\_skip\_final\_snapshot](#input\_enable\_skip\_final\_snapshot) | When DB is deleted and If this variable is false, no final snapshot will be made. | `bool` | `true` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password` is provided | `bool` | `true` | no |
| <a name="input_master_user_secret_kms_key_id"></a> [master\_user\_secret\_kms\_key\_id](#input\_master\_user\_secret\_kms\_key\_id) | The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key | `string` | `null` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Maximum storage size in GB. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Enable storage encryption. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id in which the RDS instance is to be created. | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate with the RDS cluster | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#output\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_db_instance_cloudwatch_log_groups"></a> [db\_instance\_cloudwatch\_log\_groups](#output\_db\_instance\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_db_instance_engine"></a> [db\_instance\_engine](#output\_db\_instance\_engine) | The database engine |
| <a name="output_db_instance_engine_version_actual"></a> [db\_instance\_engine\_version\_actual](#output\_db\_instance\_engine\_version\_actual) | The running version of the database |
| <a name="output_db_instance_hosted_zone_id"></a> [db\_instance\_hosted\_zone\_id](#output\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_db_instance_identifier"></a> [db\_instance\_identifier](#output\_db\_instance\_identifier) | The RDS instance ID |
| <a name="output_db_instance_master_user_secret_arn"></a> [db\_instance\_master\_user\_secret\_arn](#output\_db\_instance\_master\_user\_secret\_arn) | The ARN of the AWS Secrets Manager secret created |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | The database name |
| <a name="output_db_instance_port"></a> [db\_instance\_port](#output\_db\_instance\_port) | The database port |
| <a name="output_db_instance_resource_id"></a> [db\_instance\_resource\_id](#output\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_db_instance_status"></a> [db\_instance\_status](#output\_db\_instance\_status) | The RDS instance status |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | The master username for the database |
| <a name="output_db_parameter_group_arn"></a> [db\_parameter\_group\_arn](#output\_db\_parameter\_group\_arn) | The ARN of the db parameter group |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | The db parameter group id |
| <a name="output_db_subnet_group_arn"></a> [db\_subnet\_group\_arn](#output\_db\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_db_subnet_group_id"></a> [db\_subnet\_group\_id](#output\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the monitoring role |
<!-- END_TF_DOCS -->