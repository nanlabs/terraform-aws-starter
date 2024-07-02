variable "name" {
  description = "Name to use for servers, tags, etc"
  type        = string
  default     = "name"
}

variable "namespace" {
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  type        = string
  default     = "development"
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}

data "aws_caller_identity" "aws" {}

locals {
  tf_tags = {
    ManagedBy = "Terraform",
    By        = data.aws_caller_identity.aws.arn
  }
}
