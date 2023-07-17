region                     = "us-west-2"
name                       = "core"
namespace                  = "nan"
environment                = "staging"
vpc_cidr_block             = "10.0.0.0/16"
example_db_name            = "example"
example_db_master_username = "master"
tags = {
  "Terraform"   = "true"
  "Environment" = "staging"
}
