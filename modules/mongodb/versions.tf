terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "2.17.0"
    }
  }

  required_version = ">= 1.11"
}
