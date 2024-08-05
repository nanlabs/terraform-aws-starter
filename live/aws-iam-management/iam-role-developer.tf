module "developer_role" {
  source             = "../../modules/iam-role"
  name               = "${module.label.id}-DeveloperRole"
  policy_description = "Developer access to specific AWS resources"
  role_description   = "IAM role with permissions to manage resources needed for development"
  principals = {
    AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
  }
  policy_documents = [
    data.aws_iam_policy_document.developer_access.json
  ]
}

data "aws_iam_policy_document" "developer_access" {
  statement {
    sid    = "DeveloperAccess"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::*/*",
    ]
    actions = [
      "s3:GetObject"
    ]
  }
}

output "developer_role_name" {
  value       = module.developer_role.name
  description = "The name of the IAM role created"
}

output "developer_role_id" {
  value       = module.developer_role.id
  description = "The stable and unique string identifying the role"
}

output "developer_role_arn" {
  value       = module.developer_role.arn
  description = "The Amazon Resource Name (ARN) specifying the role"
}
