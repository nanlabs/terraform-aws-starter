variable "core_networking_ssm_parameter_prefix" {
  description = "The SSM parameter prefix for core networking parameters"
  type        = string
}

variable "bastion_security_group_name" {
  description = "The name of the bastion security group"
  type        = string
}

locals {
  vpc_id          = data.aws_ssm_parameter.vpc_id.value
  private_subnets = split(",", data.aws_ssm_parameter.private_subnets.value)
  public_subnets  = split(",", data.aws_ssm_parameter.public_subnets.value)
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${var.core_networking_ssm_parameter_prefix}/vpc_id"
}

data "aws_ssm_parameter" "private_subnets" {
  name = "${var.core_networking_ssm_parameter_prefix}/private_subnets"
}

data "aws_ssm_parameter" "public_subnets" {
  name = "${var.core_networking_ssm_parameter_prefix}/public_subnets"
}

data "aws_ssm_parameter" "app_security_group" {
  name = "${var.core_networking_ssm_parameter_prefix}/app_security_group"
}

data "aws_security_group" "default" {
  vpc_id = local.vpc_id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_vpc" "vpc" {
  id = local.vpc_id
}

data "aws_security_group" "bastion_security_group" {
  name   = var.bastion_security_group_name
  vpc_id = data.aws_vpc.vpc.id
}

data "aws_security_group" "app_security_group" {
  id     = data.aws_ssm_parameter.app_security_group.value
  vpc_id = data.aws_vpc.vpc.id
}
