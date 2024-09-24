<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kafka"></a> [kafka](#module\_kafka) | cloudposse/msk-apache-kafka-cluster/aws | 2.4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_group_rules"></a> [additional\_security\_group\_rules](#input\_additional\_security\_group\_rules) | A list of Security Group rule objects to add to the created security group, in addition to the ones<br>this module normally creates. (To suppress the module's rules, set `create_security_group` to false<br>and supply your own security group(s) via `associated_security_group_ids`.)<br>The keys and values of the objects are fully compatible with the `aws_security_group_rule` resource, except<br>for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique and known at "plan" time.<br>For more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule<br>and https://github.com/cloudposse/terraform-aws-security-group. | `list(any)` | `[]` | no |
| <a name="input_allow_all_egress"></a> [allow\_all\_egress](#input\_allow\_all\_egress) | If `true`, the created security group will allow egress on all ports and protocols to all IP addresses.<br>If this is false and no egress rules are otherwise specified, then no egress will be allowed. | `bool` | `true` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of IPv4 CIDRs to allow access to the security group created by this module.<br>The length of this list must be known at "plan" time. | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | A list of IDs of Security Groups to allow access to the security group created by this module.<br>The length of this list must be known at "plan" time. | `list(string)` | `[]` | no |
| <a name="input_associated_security_group_ids"></a> [associated\_security\_group\_ids](#input\_associated\_security\_group\_ids) | A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.<br>These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access. | `list(string)` | `[]` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | To automatically expand your cluster's storage in response to increased usage, you can enable this. [More info](https://docs.aws.amazon.com/msk/latest/developerguide/msk-autoexpand.html) | `bool` | `true` | no |
| <a name="input_broker_dns_records_count"></a> [broker\_dns\_records\_count](#input\_broker\_dns\_records\_count) | This variable specifies how many DNS records to create for the broker endpoints in the DNS zone provided in the `zone_id` variable.<br>This corresponds to the total number of broker endpoints created by the module.<br>Calculate this number by multiplying the `broker_per_zone` variable by the subnet count.<br>This variable is necessary to prevent the Terraform error:<br>The "count" value depends on resource attributes that cannot be determined until apply, so Terraform cannot predict how many instances will be created. | `number` | `0` | no |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input\_broker\_instance\_type) | Specify the instance type to use for the kafka brokers | `string` | n/a | yes |
| <a name="input_broker_per_zone"></a> [broker\_per\_zone](#input\_broker\_per\_zone) | Number of Kafka brokers per zone | `number` | `1` | no |
| <a name="input_broker_volume_size"></a> [broker\_volume\_size](#input\_broker\_volume\_size) | The size in GiB of the EBS volume for the data drive on each broker node | `number` | `1000` | no |
| <a name="input_certificate_authority_arns"></a> [certificate\_authority\_arns](#input\_certificate\_authority\_arns) | List of ACM Certificate Authority Amazon Resource Names (ARNs) to be used for TLS client authentication | `list(string)` | `[]` | no |
| <a name="input_client_allow_unauthenticated"></a> [client\_allow\_unauthenticated](#input\_client\_allow\_unauthenticated) | Enable unauthenticated access | `bool` | `false` | no |
| <a name="input_client_broker"></a> [client\_broker](#input\_client\_broker) | Encryption setting for data in transit between clients and brokers. Valid values: `TLS`, `TLS_PLAINTEXT`, and `PLAINTEXT` | `string` | `"TLS"` | no |
| <a name="input_client_sasl_iam_enabled"></a> [client\_sasl\_iam\_enabled](#input\_client\_sasl\_iam\_enabled) | Enable client authentication via IAM policies. Cannot be set to `true` at the same time as `client_tls_auth_enabled` | `bool` | `false` | no |
| <a name="input_client_sasl_scram_enabled"></a> [client\_sasl\_scram\_enabled](#input\_client\_sasl\_scram\_enabled) | Enable SCRAM client authentication via AWS Secrets Manager. Cannot be set to `true` at the same time as `client_tls_auth_enabled` | `bool` | `false` | no |
| <a name="input_client_sasl_scram_secret_association_arns"></a> [client\_sasl\_scram\_secret\_association\_arns](#input\_client\_sasl\_scram\_secret\_association\_arns) | List of AWS Secrets Manager secret ARNs for SCRAM authentication | `list(string)` | `[]` | no |
| <a name="input_client_sasl_scram_secret_association_enabled"></a> [client\_sasl\_scram\_secret\_association\_enabled](#input\_client\_sasl\_scram\_secret\_association\_enabled) | Enable the list of AWS Secrets Manager secret ARNs for SCRAM authentication | `bool` | `true` | no |
| <a name="input_client_tls_auth_enabled"></a> [client\_tls\_auth\_enabled](#input\_client\_tls\_auth\_enabled) | Set `true` to enable the Client TLS Authentication | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_log_group"></a> [cloudwatch\_logs\_log\_group](#input\_cloudwatch\_logs\_log\_group) | Name of the Cloudwatch Log Group to deliver logs to | `string` | `null` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Set `true` to create and configure a new security group. If false, `associated_security_group_ids` must be provided. | `bool` | `true` | no |
| <a name="input_custom_broker_dns_name"></a> [custom\_broker\_dns\_name](#input\_custom\_broker\_dns\_name) | Custom Route53 DNS hostname for MSK brokers. Use `%%ID%%` key to specify brokers index in the hostname. Example: `kafka-broker%%ID%%.example.com` | `string` | `null` | no |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn) | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest | `string` | `""` | no |
| <a name="input_encryption_in_cluster"></a> [encryption\_in\_cluster](#input\_encryption\_in\_cluster) | Whether data communication among broker nodes is encrypted | `bool` | `true` | no |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring) | Specify the desired enhanced MSK CloudWatch monitoring level. Valid values: `DEFAULT`, `PER_BROKER`, and `PER_TOPIC_PER_BROKER` | `string` | `"DEFAULT"` | no |
| <a name="input_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#input\_firehose\_delivery\_stream) | Name of the Kinesis Data Firehose delivery stream to deliver logs to | `string` | `""` | no |
| <a name="input_firehose_logs_enabled"></a> [firehose\_logs\_enabled](#input\_firehose\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose | `bool` | `false` | no |
| <a name="input_inline_rules_enabled"></a> [inline\_rules\_enabled](#input\_inline\_rules\_enabled) | NOT RECOMMENDED. Create rules "inline" instead of as separate `aws_security_group_rule` resources.<br>See [#20046](https://github.com/hashicorp/terraform-provider-aws/issues/20046) for one of several issues with inline rules.<br>See [this post](https://github.com/hashicorp/terraform-provider-aws/pull/9032#issuecomment-639545250) for details on the difference between inline rules and rule resources. | `bool` | `false` | no |
| <a name="input_jmx_exporter_enabled"></a> [jmx\_exporter\_enabled](#input\_jmx\_exporter\_enabled) | Set `true` to enable the JMX Exporter | `bool` | `false` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | The desired Kafka software version.<br>Refer to https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html for more details | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for the resources | `string` | n/a | yes |
| <a name="input_node_exporter_enabled"></a> [node\_exporter\_enabled](#input\_node\_exporter\_enabled) | Set `true` to enable the Node Exporter | `bool` | `false` | no |
| <a name="input_preserve_security_group_id"></a> [preserve\_security\_group\_id](#input\_preserve\_security\_group\_id) | When `false` and `security_group_create_before_destroy` is `true`, changes to security group rules<br>cause a new security group to be created with the new rules, and the existing security group is then<br>replaced with the new one, eliminating any service interruption.<br>When `true` or when changing the value (from `false` to `true` or from `true` to `false`),<br>existing security group rules will be deleted before new ones are created, resulting in a service interruption,<br>but preserving the security group itself.<br>**NOTE:** Setting this to `true` does not guarantee the security group will never be replaced,<br>it only keeps changes to the security group rules from triggering a replacement.<br>See the [terraform-aws-security-group README](https://github.com/cloudposse/terraform-aws-security-group) for further discussion. | `bool` | `false` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnets in the VPC | `list(string)` | n/a | yes |
| <a name="input_properties"></a> [properties](#input\_properties) | Contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html) | `map(string)` | `{}` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Enable public access to MSK cluster (given that all of the requirements are met) | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket) | Name of the S3 bucket to deliver logs to | `string` | `""` | no |
| <a name="input_s3_logs_enabled"></a> [s3\_logs\_enabled](#input\_s3\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to S3 | `bool` | `false` | no |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix) | Prefix to append to the S3 folder name logs are delivered to | `string` | `""` | no |
| <a name="input_security_group_create_before_destroy"></a> [security\_group\_create\_before\_destroy](#input\_security\_group\_create\_before\_destroy) | Set `true` to enable terraform `create_before_destroy` behavior on the created security group.<br>We only recommend setting this `false` if you are importing an existing security group<br>that you do not want replaced and therefore need full control over its name.<br>Note that changing this value will always cause the security group to be replaced. | `bool` | `true` | no |
| <a name="input_security_group_create_timeout"></a> [security\_group\_create\_timeout](#input\_security\_group\_create\_timeout) | How long to wait for the security group to be created. | `string` | `"10m"` | no |
| <a name="input_security_group_delete_timeout"></a> [security\_group\_delete\_timeout](#input\_security\_group\_delete\_timeout) | How long to retry on `DependencyViolation` errors during security group deletion from<br>lingering ENIs left by certain AWS services such as Elastic Load Balancing. | `string` | `"15m"` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description to assign to the created Security Group.<br>Warning: Changing the description causes the security group to be replaced. | `string` | `"Managed by Terraform"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name to assign to the created security group. Must be unique within the VPC.<br>If not provided, will be derived from the `null-label.context` passed in.<br>If `create_before_destroy` is true, will be used as a name prefix. | `list(string)` | `[]` | no |
| <a name="input_security_group_rule_description"></a> [security\_group\_rule\_description](#input\_security\_group\_rule\_description) | The description to place on each security group rule. | `string` | `"Allow inbound %s traffic"` | no |
| <a name="input_storage_autoscaling_disable_scale_in"></a> [storage\_autoscaling\_disable\_scale\_in](#input\_storage\_autoscaling\_disable\_scale\_in) | If the value is true, scale in is disabled and the target tracking policy won't remove capacity from the scalable resource | `bool` | `false` | no |
| <a name="input_storage_autoscaling_max_capacity"></a> [storage\_autoscaling\_max\_capacity](#input\_storage\_autoscaling\_max\_capacity) | Maximum size the autoscaling policy can scale storage. Defaults to `broker_volume_size` | `number` | `null` | no |
| <a name="input_storage_autoscaling_target_value"></a> [storage\_autoscaling\_target\_value](#input\_storage\_autoscaling\_target\_value) | Percentage of storage used to trigger autoscaled storage increase | `number` | `60` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for the resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the EKS cluster will be created | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 DNS Zone ID for MSK broker hostnames | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Comma separated list of one or more hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka cluster |
| <a name="output_bootstrap_brokers_public_sasl_iam"></a> [bootstrap\_brokers\_public\_sasl\_iam](#output\_bootstrap\_brokers\_public\_sasl\_iam) | Comma separated list of one or more DNS names (or IP addresses) and SASL IAM port pairs for public access to the Kafka cluster using SASL/IAM |
| <a name="output_bootstrap_brokers_public_sasl_scram"></a> [bootstrap\_brokers\_public\_sasl\_scram](#output\_bootstrap\_brokers\_public\_sasl\_scram) | Comma separated list of one or more DNS names (or IP addresses) and SASL SCRAM port pairs for public access to the Kafka cluster using SASL/SCRAM |
| <a name="output_bootstrap_brokers_public_tls"></a> [bootstrap\_brokers\_public\_tls](#output\_bootstrap\_brokers\_public\_tls) | Comma separated list of one or more DNS names (or IP addresses) and TLS port pairs for public access to the Kafka cluster using TLS |
| <a name="output_bootstrap_brokers_sasl_iam"></a> [bootstrap\_brokers\_sasl\_iam](#output\_bootstrap\_brokers\_sasl\_iam) | Comma separated list of one or more DNS names (or IP addresses) and SASL IAM port pairs for access to the Kafka cluster using SASL/IAM |
| <a name="output_bootstrap_brokers_sasl_scram"></a> [bootstrap\_brokers\_sasl\_scram](#output\_bootstrap\_brokers\_sasl\_scram) | Comma separated list of one or more DNS names (or IP addresses) and SASL SCRAM port pairs for access to the Kafka cluster using SASL/SCRAM |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | Comma separated list of one or more DNS names (or IP addresses) and TLS port pairs for access to the Kafka cluster using TLS |
| <a name="output_broker_endpoints"></a> [broker\_endpoints](#output\_broker\_endpoints) | List of broker endpoints |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of the MSK cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The cluster name of the MSK cluster |
| <a name="output_config_arn"></a> [config\_arn](#output\_config\_arn) | Amazon Resource Name (ARN) of the MSK configuration |
| <a name="output_current_version"></a> [current\_version](#output\_current\_version) | Current version of the MSK Cluster |
| <a name="output_hostnames"></a> [hostnames](#output\_hostnames) | List of MSK Cluster broker DNS hostnames |
| <a name="output_latest_revision"></a> [latest\_revision](#output\_latest\_revision) | Latest revision of the MSK configuration |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the created security group |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group rule for the MSK cluster |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group rule for the MSK cluster |
| <a name="output_storage_mode"></a> [storage\_mode](#output\_storage\_mode) | Storage mode for supported storage tiers |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | Comma separated list of one or more hostname:port pairs to connect to the Apache Zookeeper cluster |
| <a name="output_zookeeper_connect_string_tls"></a> [zookeeper\_connect\_string\_tls](#output\_zookeeper\_connect\_string\_tls) | Comma separated list of one or more hostname:port pairs to connect to the Apache Zookeeper cluster via TLS |
<!-- END_TF_DOCS -->