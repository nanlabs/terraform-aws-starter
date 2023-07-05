# Bastion Host

Terraform module to bootstrap a bastion host in AWS using EC2.

## Usage

```hcl
module "bastion" {
  source                       = "../../modules/bastion"
  region = "us-west-2"

  name                         = "example-bastion"

  vpc_id                       = "vpc-1234567890"
  subnets                      = ["subnet-1234567890", "subnet-0987654321"]
  associate_public_ip_address  = true
  associate_elastic_ip_address = true
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).

## EC2 Instance Provisioning

The created EC2 instance is provisioned using [cloud-init](https://cloudinit.readthedocs.io/en/latest/). The following steps are performed:

- Install the latest version of Docker
- Setup AWS CloudWatch Logs agent
- Setup SSH access for the specified key pair
- Setup a user account for the specified key pair
- Setup a user account for the specified IAM instance profile
