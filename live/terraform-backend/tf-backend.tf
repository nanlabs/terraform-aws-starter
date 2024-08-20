# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.4.1"

  name        = var.name
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  attributes  = ["state"]

  terraform_state_file = "${module.label.id}.tfstate"

  bucket_enabled   = true
  dynamodb_enabled = false

  force_destroy = true
}

resource "local_file" "terraform_backend_config" {
  filename        = "${path.module}/configs/${var.environment}-backend.tfvars"
  file_permission = "0644"
  content         = <<EOF
region  = "${var.region}"
bucket  = "${module.terraform_state_backend.s3_bucket_id}"
key     = "${module.label.id}.tfstate"
encrypt = "true"
profile = ""
EOF
}
