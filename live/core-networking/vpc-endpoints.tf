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
  }

  security_group_ids = [module.vpc.default_security_group_id]
  tags               = module.label.tags
}
