module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "${var.name}-ec2"
  description = "Allow traffic on all ports and ip ranges"
  vpc_id      = var.vpc_id

  egress_rules = ["all-all"]

  tags = var.tags
}

module "ssm_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  count = var.create_vpc_endpoints ? 1 : 0

  name        = "${var.name}-vpc-ssm-vpce-security-group"
  description = "Security group for SSM VPC endpoint"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = concat([
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.ec2_security_group.security_group_id
      description              = "vpc ssm vpce security group ingress rule for bastion host"
    }
  ])

  tags = var.tags
}

module "ec2messages_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  count = var.create_vpc_endpoints ? 1 : 0

  name        = "${var.name}-vpc-ec2messages-vpce-security-group"
  description = "Security group for EC2 Messages VPC endpoint"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.ec2_security_group.security_group_id
      description              = "vpc ec2 messages vpce security group ingress rule for bastion host"
    }
  ]

  tags = var.tags
}

module "ssmmessages_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  count = var.create_vpc_endpoints ? 1 : 0

  name        = "${var.name}-vpc-ssmmessages-vpce-security-group"
  description = "Security group for SSM Messages VPC endpoint"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.ec2_security_group.security_group_id
      description              = "vpc ssm messages vpce security group ingress rule for bastion host"
    }
  ]

  tags = var.tags
}
