# Iam Role Module

Terraform module to create an AWS IAM role with a policy attached.

## Usage

This example creates a role with the name eg-prod-app with permission to grant read-write access to S3 bucket, and gives permission to the entities specified in principals_arns to assume the role.

```hcl
data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["arn:aws:s3:::bucketname/path/*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["arn:aws:s3:::bucketname"]
    effect    = "Allow"
  }
}

module "role" {
  source = "../../modules/iam-role"

  name      = "eg-prod-app"

  policy_description = "Allow S3 FullAccess"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  principals = {
    AWS = ["arn:aws:iam::123456789012:role/workers"]
  }

  policy_documents = [
    data.aws_iam_policy_document.resource_full_access.json,
    data.aws_iam_policy_document.base.json
  ]
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
