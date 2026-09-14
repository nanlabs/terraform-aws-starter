# Connecting to private RDS using EC2 Instance Connect Endpoint (EICE)?
An EC2 Instance Connect Endpoint (EICE) is an AWS-managed VPC service feature that allows secure TCP connectivity to private instances and resources in your VPC—without needing a public IP, a Internet Gateway (IGW), or a dedicated bastion host running 24/7.

It acts as an on-demand, serverless private bridge inside your subnets. When you request a connection via the AWS CLI, AWS establishes a secure WebSocket tunnel between your local machine and the endpoint inside your VPC, which then forwards the connection to your destination (like private RDS).


# Key Aspect:

| Feature / Aspect | Traditional EC2 Bastion Host | EC2 Instance Connect Endpoint (EICE) |
| :--- | :--- | :--- |
| **Cost** | Runs 24/7 (EC2 compute, EBS storage, Elastic IP fees). | Zero compute cost (No EC2 instances; free hourly usage, pay standard data transfer). |
| **Maintenance** | Requires OS patching, security updates, and key management. | Fully managed by AWS (no OS or software to manage/patch). |
| **Access Control** | SSH keys (.pem files), vulnerable to key leaks and poor rotation. | IAM & STS based (short-lived temporary credentials, fine-grained access policies). |
| **Network Attack Surface** | Publicly accessible IP listening on port 22. | No public IP required on target resources or endpoint; lives entirely inside the private VPC. |
| **Auditability** | Manual SSH log tracking on the instance. | Native integration with AWS CloudTrail for auditing tunnel requests. |


# How to connect to RDS: 
![alt text](<Screenshot 2026-07-26 224054.png>)

Step 1: Find the Private IP of Your RDS Instance
The AWS CLI tunnel command requires a target IPv4 address. Retrieve it via DNS lookup or from your Terraform output:

```
nslookup <your-rds-endpoint.cxxxxx.us-east-1.rds.amazonaws.com>
```

Step 2: Open the Secure Tunnel
Run the following AWS CLI command in your terminal:

```
aws ec2-instance-connect open-tunnel `
  --instance-connect-endpoint-id eice-0123456789abcdef0 `
  --private-ip-address 10.0.1.45 `
  --local-port 5432 `
  --remote-port 5432
```

Leave this terminal process running in the background. It listens on 127.0.0.1:5432 and tunnels all incoming local traffic over WebSocket to your private RDS instance.

Step 3: Connect using standard DB Clients / GUI Tools <br>
In a separate terminal or SQL client tool (such as DBeaver, PgAdmin, VS Code extensions, or psql), connect using:

* Host: 127.0.0.1 (or localhost)
* Port: 5432
* Database: myappdb
* User: dbadmin

```
psql -h 127.0.0.1 -p 5432 -U dbadmin -d myappdb
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.56.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_db_instance.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.created](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_ec2_instance_connect_endpoint.eic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_connect_endpoint) | resource |
| [aws_security_group.eic_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eic_egress_to_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rds_ingress_from_eic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.private_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_Environment"></a> [Environment](#input\_Environment) | Environment name | `string` | `"testing"` | no |
| <a name="input_additional_security_group_ids"></a> [additional\_security\_group\_ids](#input\_additional\_security\_group\_ids) | Additional security group IDs to attach to the RDS instance (merged with default SG). | `list(string)` | `[]` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | String size in GB | `number` | `20` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy resources in. | `string` | `"us-east-1"` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | Backup retention period in days | `string` | `"1"` | no |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | Preferred backup window | `string` | `"03:00-06:00"` | no |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | The databse engine to be used for RDS | `string` | `"postgres"` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | The database engine version | `string` | `"16.3"` | no |
| <a name="input_db_family"></a> [db\_family](#input\_db\_family) | The family to the database engine to be used for RDS | `string` | `"postgres16"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class to use for RDS | `string` | `"db.t4.small"` | no |
| <a name="input_db_instance_window"></a> [db\_instance\_window](#input\_db\_instance\_window) | Preferred maintance window | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Password for the master DB user. Required unless `manage_master_user_password` is set to `true` or unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database | `string` | `null` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | Database username | `string` | `"name"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | database username | `string` | `"name"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | dDatabase port | `number` | `5432` | no |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | The strong type for RDS | `string` | `null` | no |
| <a name="input_db_subnet_group"></a> [db\_subnet\_group](#input\_db\_subnet\_group) | Database subnet group to use. Leave blank to create a new one. | `string` | `""` | no |
| <a name="input_enable_multi_az"></a> [enable\_multi\_az](#input\_enable\_multi\_az) | create RDS instance in multiple availability zones | `bool` | `false` | no |
| <a name="input_enable_public_access"></a> [enable\_public\_access](#input\_enable\_public\_access) | Enable public access for RDS. | `bool` | `false` | no |
| <a name="input_enable_skip_final_snapshot"></a> [enable\_skip\_final\_snapshot](#input\_enable\_skip\_final\_snapshot) | When DB is deleted and if this variable is false, no false snapshot will be made. | `bool` | `true` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | The major engine version | `string` | `"16"` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in secrets manager. Cannot be set if `master_password` is provided | `bool` | `true` | no |
| <a name="input_master_user_secret_kms_key_id"></a> [master\_user\_secret\_kms\_key\_id](#input\_master\_user\_secret\_kms\_key\_id) | The Amazon Web Services KMS key identifier is the key ID, alias ARN, or alias name for the KMS key | `string` | `null` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Preferred maintenance window. | `number` | `100` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used for all the resources as identifier | `string` | `"app-db"` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Enabled storage encryption | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Any extra tage to assign to objects | `map(any)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id in which to create the RDS instance | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | list of VPC security groups to associate with the RDS cluster | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_eic_endpoint_id"></a> [eic\_endpoint\_id](#output\_eic\_endpoint\_id) | The ID of the EC2 Instance Connect Endpoint |
| <a name="output_master_user_secret_arn"></a> [master\_user\_secret\_arn](#output\_master\_user\_secret\_arn) | ARN of the Secret Manager secret for master password (if managed by AWS) |
| <a name="output_rds_address"></a> [rds\_address](#output\_rds\_address) | The address of the RDS instance |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | The connection endpoint of the RDS instance |
| <a name="output_rds_port"></a> [rds\_port](#output\_rds\_port) | The database port |
<!-- END_TF_DOCS -->