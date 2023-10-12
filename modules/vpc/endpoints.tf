data "aws_region" "current" {}

resource "aws_vpc_endpoint" "secrets_manager" {
  vpc_id = module.vpc.vpc_id

  service_name = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"

  security_group_ids = [module.app_security_group.security_group_id]  # You can specify security groups if needed
  subnet_ids         = module.vpc.private_subnets  # Associate with private subnets
}
