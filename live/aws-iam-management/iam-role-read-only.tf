module "read_only_role" {
  source             = "../../modules/iam-role"
  name               = "${module.label.id}-ReadOnlyRole"
  policy_description = "Read-only access to all AWS resources"
  role_description   = "IAM role with read-only access permissions"
  principals = {
    AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  }
  policy_document_count = 0
  managed_policy_arns   = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

output "read_only_role_name" {
  value       = module.read_only_role.name
  description = "The name of the IAM role created"
}

output "read_only_role_id" {
  value       = module.read_only_role.id
  description = "The stable and unique string identifying the role"
}

output "read_only_role_arn" {
  value       = module.read_only_role.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}
