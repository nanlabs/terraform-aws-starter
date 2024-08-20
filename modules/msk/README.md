# Terraform Module: Amazon MSK Cluster

This Terraform module is used to create an Amazon Managed Streaming for Apache Kafka (MSK) cluster.

## Prerequisites

Before using this module, make sure you have the following prerequisites:

- An AWS account
- Terraform installed on your local machine. Consider using `tfswitch`

## Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "msk_cluster" {
  source  = "path/to/module"
  cluster_name = "my-msk-cluster"
  kafka_version = "2.8.0"
  instance_type = "kafka.m5.large"
  num_broker_nodes = 3
  subnet_ids = ["subnet-12345678", "subnet-87654321"]
  security_group_ids = ["sg-12345678", "sg-87654321"]
}
```

Replace `path/to/module` with the actual path to this module.

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
