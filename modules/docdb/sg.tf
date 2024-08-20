data "aws_vpc" "main" {
  id = var.vpc_id
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name}-docdb-security-group"
  description = "Security group for ${var.name}-docdb"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      description = "DocumentDB access from within VPC"
      cidr_blocks = data.aws_vpc.main.cidr_block
    }
  ]

  egress_rules = ["all-all"]

  tags = var.tags
}
