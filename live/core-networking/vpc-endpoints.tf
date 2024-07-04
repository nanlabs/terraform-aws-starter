module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = module.vpc.public_route_table_ids
      policy          = null
      tags            = { Name = "${module.label.id}-s3-vpc-endpoint" }
    },
    ec2 = {
      service             = "ec2"
      service_type        = "Interface"
      security_group_ids  = [module.vpc.default_security_group_id, module.vpc.app_security_group]
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = null
      tags                = { Name = "${module.label.id}-ec2-vpc-endpoint" }
    }
  }

  security_group_ids = [module.vpc.default_security_group_id, module.vpc.app_security_group]
  tags               = module.label.tags
}
