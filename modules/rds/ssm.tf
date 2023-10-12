resource "aws_ssm_parameter" "address" {
  name  = "/${var.name}/address"
  type  = "String"
  value = module.db.db_instance_address
}

resource "aws_ssm_parameter" "name" {
  name  = "/${var.name}/name"
  type  = "String"
  value = module.db.db_instance_name
}

resource "aws_ssm_parameter" "port" {
  name  = "/${var.name}/port"
  type  = "String"
  value = module.db.db_instance_port
}

resource "aws_ssm_parameter" "master_user_secret_arn" {
  name  = "/${var.name}/master_user_secret_arn"
  type  = "String"
  value = module.db.db_instance_master_user_secret_arn
}
