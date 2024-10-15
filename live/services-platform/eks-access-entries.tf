variable "namespaces" {
  description = "List of namespaces to create access entries"
  type        = list(string)
  default     = []
}

data "aws_iam_policy_document" "eks_policies" {
  for_each = local.access_policy_map

  statement {
    actions = [
      "eks:Describe*",
      "eks:List*",
    ]
    resources = ["arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${module.eks_cluster.eks_cluster_id}"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "eks_policies" {
  for_each = local.access_policy_map

  name        = "${module.label.id}-${each.key}-policy"
  description = "Custom policy for EKS ${each.key} role"
  policy      = data.aws_iam_policy_document.eks_policies[each.key].json
}

locals {
  namespaces = var.namespaces
  access_policy_map = {
    "admin" = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
    "dev"   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"
    "view"  = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  }
  namespaces_to_roles = {
    for ns in local.namespaces : ns => {
      "admin" = "${ns}-admin"
      "dev"   = "${ns}-dev"
      "view"  = "${ns}-view"
    }
  }
  flattened_map = flatten([
    for ns, roles in local.namespaces_to_roles : [
      for role, name in roles : {
        namespace         = ns
        role              = role
        name              = name
        access_policy_arn = local.access_policy_map[role]
      }
    ]
  ])
}

resource "aws_iam_role" "eks_roles" {
  for_each = {
    for entry in local.flattened_map : "${entry.namespace}-${entry.role}" => entry
  }

  name = "${module.label.id}-eks-role-${each.value.namespace}-${each.value.role}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policies" {
  for_each = {
    for entry in local.flattened_map : "${entry.namespace}-${entry.role}" => entry
  }
  role       = aws_iam_role.eks_roles[each.key].name
  policy_arn = aws_iam_policy.eks_policies[each.value.role].arn

  depends_on = [aws_iam_policy.eks_policies]
}

locals {
  access_entries = {
    for idx, entry in local.flattened_map : aws_iam_role.eks_roles["${entry.namespace}-${entry.role}"].arn => {
      kubernetes_groups = ["${entry.namespace}:${entry.role}"]
      type              = "STANDARD"
    }
  }
}


resource "aws_eks_access_entry" "access_entries" {
  for_each = {
    for entry in local.flattened_map : "${entry.namespace}-${entry.role}" => entry
  }
  cluster_name      = module.eks_cluster.eks_cluster_id
  principal_arn     = aws_iam_role.eks_roles["${each.value.namespace}-${each.value.role}"].arn
  kubernetes_groups = ["${each.value.namespace}:${each.value.role}"]
  type              = "STANDARD"

  depends_on = [aws_iam_role.eks_roles]
}

resource "aws_eks_access_policy_association" "access_policies_associations" {
  for_each = {
    for entry in local.flattened_map : "${entry.namespace}-${entry.role}" => entry
  }
  cluster_name  = module.eks_cluster.eks_cluster_id
  policy_arn    = each.value.access_policy_arn
  principal_arn = aws_iam_role.eks_roles["${each.value.namespace}-${each.value.role}"].arn

  access_scope {
    type       = "namespace"
    namespaces = [each.value.namespace]
  }
}


resource "aws_iam_policy" "ebs_csi_policy" {
  name = "${module.label.id}-ebs-csi-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:DeleteVolume",
          "ec2:DetachVolume",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeVolumes"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ebs_csi_policy" {
  for_each   = toset(module.eks_cluster.eks_cluster_node_group_roles_names)
  role       = each.value
  policy_arn = aws_iam_policy.ebs_csi_policy.arn
}
