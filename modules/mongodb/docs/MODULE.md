<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | 1.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 1.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [mongodbatlas_cluster.cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/cluster) | resource |
| [mongodbatlas_database_user.user](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/database_user) | resource |
| [mongodbatlas_network_peering.mongo_peer](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/network_peering) | resource |
| [mongodbatlas_project.project](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/project) | resource |
| [mongodbatlas_project_ip_access_list.access_list](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/project_ip_access_list) | resource |
| [mongodbatlas_teams.team](https://registry.terraform.io/providers/mongodb/mongodbatlas/1.12.1/docs/resources/teams) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_lists"></a> [access\_lists](#input\_access\_lists) | An object that contains all the network white-lists that should be created in the project | `map(any)` | `{}` | no |
| <a name="input_auto_scaling_disk_gb_enabled"></a> [auto\_scaling\_disk\_gb\_enabled](#input\_auto\_scaling\_disk\_gb\_enabled) | Indicating if disk auto-scaling is enabled | `bool` | `true` | no |
| <a name="input_backing_provider_name"></a> [backing\_provider\_name](#input\_backing\_provider\_name) | The cloud provider to use for the cluster | `string` | `null` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Indicating if the cluster uses Cloud Backup for backups | `bool` | `true` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The cluster name | `string` | n/a | yes |
| <a name="input_cluster_type"></a> [cluster\_type](#input\_cluster\_type) | The MongoDB Atlas cluster type - SHARDED/REPLICASET/GEOSHARDED | `string` | n/a | yes |
| <a name="input_database_users"></a> [database\_users](#input\_database\_users) | An object that contains all the database users that should be created in the project | <pre>map(object({<br>    username = string<br>    password = string<br>    role = object({<br>      role_name     = string<br>      database_name = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Capacity,in gigabytes,of the host’s root volume | `number` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The Atlas instance-type name | `string` | n/a | yes |
| <a name="input_mongodb_major_ver"></a> [mongodb\_major\_ver](#input\_mongodb\_major\_ver) | The MongoDB cluster major version | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_num_shards"></a> [num\_shards](#input\_num\_shards) | number of shards | `number` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The ID of the Atlas organization you want to create the project within | `string` | n/a | yes |
| <a name="input_pit_enabled"></a> [pit\_enabled](#input\_pit\_enabled) | Indicating if the cluster uses Continuous Cloud Backup, if set to true - provider\_backup must also be set to true | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project you want to create | `string` | n/a | yes |
| <a name="input_provider_disk_iops"></a> [provider\_disk\_iops](#input\_provider\_disk\_iops) | The maximum IOPS the system can perform | `number` | `null` | no |
| <a name="input_provider_encrypt_ebs_volume"></a> [provider\_encrypt\_ebs\_volume](#input\_provider\_encrypt\_ebs\_volume) | Indicating if the AWS EBS encryption feature encrypts the server’s root volume | `bool` | `false` | no |
| <a name="input_provider_name"></a> [provider\_name](#input\_provider\_name) | The cloud provider to use for the cluster | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region-name that the cluster will be deployed on | `string` | n/a | yes |
| <a name="input_replication_factor"></a> [replication\_factor](#input\_replication\_factor) | The Number of replica set members, possible values are 3/5/7 | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tags to assign to objects | `map(any)` | `{}` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | An object that contains all the groups that should be created in the project | `map(any)` | `{}` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | STANDARD or PROVISIONED for IOPS higher than the default instance IOPS | `string` | `null` | no |
| <a name="input_vpc_peer"></a> [vpc\_peer](#input\_vpc\_peer) | An object that contains all VPC peering requests from the cluster to AWS VPC's | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The cluster ID |
| <a name="output_connection_strings"></a> [connection\_strings](#output\_connection\_strings) | Set of connection strings that your applications use to connect to this cluster |
| <a name="output_container_id"></a> [container\_id](#output\_container\_id) | The Network Peering Container ID |
| <a name="output_mongo_db_version"></a> [mongo\_db\_version](#output\_mongo\_db\_version) | Version of MongoDB the cluster runs, in major-version.minor-version format |
| <a name="output_mongo_uri"></a> [mongo\_uri](#output\_mongo\_uri) | Base connection string for the cluster |
| <a name="output_mongo_uri_updated"></a> [mongo\_uri\_updated](#output\_mongo\_uri\_updated) | Lists when the connection string was last updated |
| <a name="output_mongo_uri_with_options"></a> [mongo\_uri\_with\_options](#output\_mongo\_uri\_with\_options) | connection string for connecting to the Atlas cluster. Includes the replicaSet, ssl, and authSource query parameters in the connection string with values appropriate for the cluster |
| <a name="output_paused"></a> [paused](#output\_paused) | Flag that indicates whether the cluster is paused or not |
| <a name="output_srv_address"></a> [srv\_address](#output\_srv\_address) | Connection string for connecting to the Atlas cluster. The +srv modifier forces the connection to use TLS/SSL |
| <a name="output_state_name"></a> [state\_name](#output\_state\_name) | Current state of the cluster |
<!-- END_TF_DOCS -->