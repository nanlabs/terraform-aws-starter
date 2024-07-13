provider "aws" {
  region = var.region

  default_tags {
    tags = merge(module.label.tags, {
      ManagedBy      = "terraform"
      Owner          = "Software-Platforms"
      Repository     = "https://github.com/Ionna-ev/terraform-infra"
      RepositoryPath = "live/core-networking"
    })
  }
}
