# General settings

region      = "us-west-2"
name        = "core-networking"
namespace   = "nan"
environment = "staging"
tags = {
  "Terraform"   = "true"
  "Environment" = "prod"
}

# AWS settings

vpc_cidr_block = "10.0.0.0/16"
enable_bastion = false
