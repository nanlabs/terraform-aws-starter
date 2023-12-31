# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.1.1"

  name        = module.label.name
  namespace   = module.label.namespace
  environment = module.label.environment
  attributes  = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "s3-backend.tf"
  terraform_state_file               = "${module.label.id}.tfstate"

  bucket_enabled   = true
  dynamodb_enabled = true

  force_destroy = false
}
