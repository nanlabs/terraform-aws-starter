module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service            = "s3"
      service_type       = "Gateway"
      route_table_ids    = module.vpc.public_route_table_ids
      security_group_ids = [module.vpc.default_security_group_id]
      policy             = null
      tags               = { Name = "${module.label.id}-s3-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      service_type        = "Interface"
      security_group_ids  = [module.ssm_vpce_sg.security_group_id]
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ssm-vpc-endpoint" }
    },
    ec2messages = {
      service             = "ec2messages"
      service_type        = "Interface"
      security_group_ids  = [module.ec2messages_vpce_sg.security_group_id]
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ec2messages-vpc-endpoint" }
    },
    ssmmessages = {
      service             = "ssmmessages"
      service_type        = "Interface"
      security_group_ids  = [module.ssmmessages_vpce_sg.security_group_id]
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = null
      tags                = { Name = "${var.name}-ssmmessages-vpc-endpoint" }
    }
  }

  tags = module.label.tags
}
