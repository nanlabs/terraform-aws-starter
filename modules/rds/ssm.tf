resource "aws_ssm_parameter" "db_instance_address" {
  name  = "/${var.name}/db_instance_address"
  type  = "StringList"
  value = module.db.db_instance_address
}

resource "aws_ssm_parameter" "db_instance_name" {
  name  = "/${var.name}/db_instance_name"
  type  = "StringList"
  value = module.db.db_instance_name
}

resource "aws_ssm_parameter" "db_instance_port" {
  name  = "/${var.name}/db_instance_port"
  type  = "StringList"
  value = module.db.db_instance_port
}

resource "aws_ssm_parameter" "db_instance_master_user_secret_arn" {
  name  = "/${var.name}/db_instance_master_user_secret_arn"
  type  = "StringList"
  value = module.db.db_instance_master_user_secret_arn
}
