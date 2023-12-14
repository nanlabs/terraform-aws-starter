locals {
  context = {
    name        = "infra"
    namespace   = "nan"
    environment = "prod"
    tags = {
      "Terraform"   = "true"
      "Environment" = "prod"
    }
  }
}

data "aws_caller_identity" "aws" {}

locals {
  tf_tags = {
    Terraform = true,
    By        = data.aws_caller_identity.aws.arn
  }
}

// Keep labels, tags consistent
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name        = local.context.name
  environment = local.context.environment
  namespace   = local.context.namespace
  stage       = local.context.stage

  delimiter   = "-"
  label_order = ["namespace", "environment", "stage", "name", "attributes"]
  tags        = merge(local.context.tags, local.tf_tags)
}
