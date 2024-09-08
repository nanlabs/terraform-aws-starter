resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}-${var.bucket_name}"

  force_destroy = var.force_destroy

  tags = merge({
    Name = "${var.name}-s3-bucket"
  }, var.tags)
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "default"
    status = var.enable_lifecycle_rule ? "Enabled" : "Disabled"

    transition {
      days          = var.lifecycle_transition_days
      storage_class = var.lifecycle_storage_class
    }

    expiration {
      days = var.lifecycle_expiration_days
    }
  }
}

resource "aws_s3_bucket_logging" "bucket_logging" {
  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.logging_bucket
  target_prefix = "${var.name}-${var.bucket_name}/logs/"
}
