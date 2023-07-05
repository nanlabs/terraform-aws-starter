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

## Inputs

| Name                         | Description                                                  |   Default   | Required |
| :--------------------------- | :----------------------------------------------------------- | :---------: | :------: |
| name                         | Name to use for resources, tags, etc                         |     ""      |          |
| tags                         | Any extra tags to assign to objects                          |     {}      |          |
| region                       | Region to deploy to                                          | "us-west-2" |          |
| vpc_id                       | VPC to use for resources                                     |     ""      |    ✅    |
| subnets                      | Subnets to use for resources                                 |     []      |    ✅    |
| associate_public_ip_address  | Whether to associate a public IP address with the instance   |    true     |          |
| associate_elastic_ip_address | Whether to associate an elastic IP address with the instance |    false    |          |
| ami                          | AMI to use for the instance                                  |     ""      |          |
| instance_type                | Instance type to use                                         | "t2.medium" |          |
| allowed_cidrs                | List of CIDRs to allow SSH access from                       | "0.0.0.0/0" |          |
| key_name                     | Name of the key pair to use for SSH access                   |     ""      |          |

## Outputs

| Name             | Description                                       |
| :--------------- | :------------------------------------------------ |
| instance_id      | ID of the bastion host                            |
| instance_profile | IAM instance profile attached to the bastion host |
| ssh_command      | SSH command to connect to the bastion host        |

## EC2 Instance Provisioning

The created EC2 instance is provisioned using [cloud-init](https://cloudinit.readthedocs.io/en/latest/). The following steps are performed:

- Install the latest version of Docker
- Setup AWS CloudWatch Logs agent
- Setup SSH access for the specified key pair
- Setup a user account for the specified key pair
- Setup a user account for the specified IAM instance profile
