# `vpc-cni` EKS addon
# https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html
# https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
# https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-role
# https://aws.github.io/aws-eks-best-practices/networking/vpc-cni/#deploy-vpc-cni-managed-add-on

# It is important to enable IPv6 support for the VPC CNI plugin
# even if IPv6 is not in use, because the addon may need to
# manage IPv6 addresses during a transition from IPv6 to IPv4
# or vice versa, or while destroying the cluster.
data "aws_iam_policy_document" "vpc_cni_ipv6" {
  # See https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AssignIpv6Addresses",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeInstanceTypes"
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
    actions   = ["ec2:CreateTags"]
  }
}

resource "aws_iam_role_policy_attachment" "vpc_cni" {
  role       = module.vpc_cni_eks_iam_role.service_account_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

module "vpc_cni_eks_iam_role" {
  source  = "cloudposse/eks-iam-role/aws"
  version = "2.2.0"

  eks_cluster_oidc_issuer_url = module.eks_cluster.eks_cluster_identity_oidc_issuer

  service_account_name      = "aws-node"
  service_account_namespace = "kube-system"

  aws_iam_policy_document = try([data.aws_iam_policy_document.vpc_cni_ipv6.json], [])

  name = var.name

  tags = var.tags
}
