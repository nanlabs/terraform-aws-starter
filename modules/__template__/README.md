# Terraform Module Template

This is a template for creating Terraform modules. It includes a basic structure for organizing your module code and documentation.

In this example, we show how to create an S3 bucket with versioning, encryption, logging, and lifecycle management. This module uses a customizable name prefix for all resources and allows extra tags to be assigned.

## Key Highlights

1. **`name` Variable**: Used as a prefix for all resources, providing an easy way to distinguish resources created by the module.
2. **`tags` Variable**: Allows additional tags to be passed to the module, merged with the default tag structure.
3. **Documentation**: The README clearly documents the purpose and examples of using the module.
4. **Module Documentation**: The module documentation is generated using [terraform-docs](https://github.com/terraform-docs/terraform-docs) and provides detailed information about the module's inputs and outputs.

## Usage

```hcl
module "s3_bucket" {
  source = "path_to_your_module"

  name             = "data-lake"
  bucket_name      = "raw-data"
  force_destroy    = true
  enable_versioning = true
  kms_key_id       = "alias/my-kms-key"
  logging_bucket   = "my-logging-bucket"

  tags = {
    Owner       = "Anton"
    Environment = "prod"
  }
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
