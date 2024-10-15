module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = var.vpc_id

  count = var.create_vpc_endpoints ? 1 : 0

  endpoints = {
    ssm = {
      service             = "ssm"
      service_type        = "Interface"
      security_group_ids  = [module.ssm_vpce_sg[0].security_group_id]
      private_dns_enabled = true
      subnet_ids          = var.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ssm-vpc-endpoint" }
    },
    ec2messages = {
      service             = "ec2messages"
      service_type        = "Interface"
      security_group_ids  = [module.ec2messages_vpce_sg[0].security_group_id]
      private_dns_enabled = true
      subnet_ids          = var.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ec2messages-vpc-endpoint" }
    },
    ssmmessages = {
      service             = "ssmmessages"
      service_type        = "Interface"
      security_group_ids  = [module.ssmmessages_vpce_sg[0].security_group_id]
      private_dns_enabled = true
      subnet_ids          = var.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ssmmessages-vpc-endpoint" }
    }
  }

  tags = var.tags
}
