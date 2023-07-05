region             = "us-west-2"
name               = "example"
namespace          = "nan"
environment        = "staging"
vpc_cidr_block     = "10.0.0.0/16"
db_name            = "example"
db_master_username = "master"
tags = {
  "Terraform"   = "true"
  "Environment" = "staging"
}
