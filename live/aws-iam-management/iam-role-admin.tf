module "admin_role" {
  source             = "../../modules/iam-role"
  name               = "${module.label.id}-AdminRole"
  policy_description = "Administrator access to all AWS resources"
  role_description   = "IAM role with full access permissions"
  principals = {
    AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  }
  policy_document_count = 0
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

output "admin_role_name" {
  value       = module.admin_role.name
  description = "The name of the IAM role created"
}

output "admin_role_id" {
  value       = module.admin_role.id
  description = "The stable and unique string identifying the role"
}

output "admin_role_arn" {
  value       = module.admin_role.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}
