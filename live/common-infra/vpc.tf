variable "core_networking_ssm_parameter_prefix" {
  description = "The SSM parameter prefix for core networking parameters"
  type        = string
}

data "aws_ssm_parameter" "vpc_id" {
  name = "${var.core_networking_ssm_parameter_prefix}/vpc_id"
}

data "aws_ssm_parameter" "app_subnets" {
  name = "${var.core_networking_ssm_parameter_prefix}/app_subnets"
}

data "aws_ssm_parameter" "database_subnets" {
  name = "${var.core_networking_ssm_parameter_prefix}/database_subnets"
}

data "aws_ssm_parameter" "database_subnet_group" {
  name = "${var.core_networking_ssm_parameter_prefix}/database_subnet_group"
}
