variable "ecr_repositories" {
  description = "List of ECR repositories to create"
  type = map(object({
    repository_image_tag_mutability = optional(string)
  }))
}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.3.0"

  for_each = var.ecr_repositories

  repository_name                 = each.key
  repository_image_tag_mutability = each.value.repository_image_tag_mutability

  repository_read_write_access_arns = concat([data.aws_caller_identity.current.arn],
    module.eks_cluster.eks_cluster_node_group_roles_arns
  )
  create_lifecycle_policy = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true

  tags = module.label.tags
}

output "ecr_repository_urls" {
  value = [
    for repo in module.ecr : repo.repository_url
  ]
  description = "List of ECR repository URLs"
}
