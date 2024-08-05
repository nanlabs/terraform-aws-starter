data "aws_iam_policy_document" "assume_role" {
  count = length(keys(var.principals))

  statement {
    effect  = "Allow"
    actions = var.assume_role_actions

    principals {
      type        = element(keys(var.principals), count.index)
      identifiers = var.principals[element(keys(var.principals), count.index)]
    }

    dynamic "condition" {
      for_each = var.assume_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_aggregated" {
  override_policy_documents = data.aws_iam_policy_document.assume_role[*].json
}

resource "aws_iam_role" "default" {
  name                 = var.name
  assume_role_policy   = join("", data.aws_iam_policy_document.assume_role_aggregated[*].json)
  description          = var.role_description
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary
  path                 = var.path
  tags = merge(var.tags, {
    "Name" = var.name
  })
}

data "aws_iam_policy_document" "default" {
  count                     = var.policy_document_count > 0 ? 1 : 0
  override_policy_documents = var.policy_documents
}

resource "aws_iam_policy" "default" {
  count       = var.policy_document_count > 0 ? 1 : 0
  name        = var.policy_name != "" && var.policy_name != null ? var.policy_name : var.name
  description = var.policy_description
  policy      = join("", data.aws_iam_policy_document.default.*.json)
  path        = var.path
  tags = merge(var.tags, {
    "Name" = var.policy_name != "" && var.policy_name != null ? var.policy_name : var.name
  })
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.policy_document_count > 0 ? 1 : 0
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = join("", aws_iam_policy.default.*.arn)
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = var.managed_policy_arns
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "default" {
  count = var.instance_profile_enabled ? 1 : 0
  name  = var.name
  role  = join("", aws_iam_role.default.*.name)
}
