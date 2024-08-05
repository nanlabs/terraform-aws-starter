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

variable "environment" {
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  type        = string
  default     = "development"
}

variable "stage" {
  description = "Stage, e.g. 'build', 'test', 'deploy', 'release'"
  type        = string
  # not required, so no default
  default = null
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}

// Keep labels, tags consistent
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name        = var.name
  environment = var.environment
  namespace   = var.namespace
  stage       = var.stage

  delimiter   = "-"
  label_order = ["namespace", "environment", "stage", "name", "attributes"]
  tags        = var.tags
}
