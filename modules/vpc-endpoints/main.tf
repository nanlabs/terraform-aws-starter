module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 3.0"

  vpc_id             = var.vpc_id
  security_group_ids = var.security_group_ids
  endpoints          = var.endpoints
  tags               = var.tags
}
