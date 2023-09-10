# General settings

region      = "us-west-2"
name        = "core"
namespace   = "nan"
environment = "prod"
tags = {
  "Terraform"   = "true"
  "Environment" = "prod"
}

# AWS settings

vpc_cidr_block = "10.0.0.0/16"
enable_bastion = false

# RDS Database settings

example_db_name            = "example"
example_db_master_username = "master"
