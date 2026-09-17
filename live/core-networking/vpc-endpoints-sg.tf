locals {
  # Check if the bastion exists (based on the length of the module.bastion array)
  bastion_sg_ingress = length(module.bastion) > 0 ? {
    bastion-https = {
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.bastion[0].security_group_id
      description                  = "vpc ssm vpce security group ingress rule for bastion host"
    }
  } : {}

  # Define the ingress rules for app security group
  app_sg_ingress = {
    app-https = {
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      referenced_security_group_id = module.vpc.app_security_group
      description                  = "vpc ssm vpce security group ingress rule for app security group"
    }
  }

  # Concatenate the rules for app SG and bastion SG (if bastion exists)
  final_ssm_vpce_rules = merge(local.app_sg_ingress, local.bastion_sg_ingress)
}

module "ssm_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name        = "${module.label.id}-vpc-ssm-vpce-security-group"
  description = "Security group for SSM VPC endpoint"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = local.final_ssm_vpce_rules

  tags = var.tags
}

module "ec2messages_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name        = "${module.label.id}-vpc-ec2messages-vpce-security-group"
  description = "Security group for EC2 Messages VPC endpoint"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = local.final_ssm_vpce_rules

  tags = var.tags
}

module "ssmmessages_vpce_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name        = "${module.label.id}-vpc-ssmmessages-vpce-security-group"
  description = "Security group for SSM Messages VPC endpoint"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = local.final_ssm_vpce_rules

  tags = var.tags
}
