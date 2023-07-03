region             = "us-west-2"
name               = "nanlabs"
namespace          = "nan"
environment        = "staging"
stage              = "stage"
vpc_cidr_block     = "10.0.0.0/16"
db_name            = "db_name"
db_master_username = "db_master_username"
tags = {
  "Terraform"   = "true"
  "Environment" = "staging"
}
