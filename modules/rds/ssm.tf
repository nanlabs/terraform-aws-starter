resource "aws_ssm_parameter" "db_address" {
  name  = "/${var.name}/db_address"
  type  = "String"
  value = module.db.db_instance_address
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/${var.name}/db_name"
  type  = "String"
  value = module.db.db_instance_name
}

resource "aws_ssm_parameter" "db_port" {
  name  = "/${var.name}/db_port"
  type  = "String"
  value = module.db.db_instance_port
}

resource "aws_ssm_parameter" "db_master_user_secret_arn" {
  name  = "/${var.name}/db_master_user_secret_arn"
  type  = "String"
  value = module.db.db_instance_master_user_secret_arn
}
