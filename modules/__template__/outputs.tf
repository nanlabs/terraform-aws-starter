output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "logging_bucket" {
  description = "The logging bucket for the S3 bucket"
  value       = aws_s3_bucket_logging.bucket_logging.target_bucket
}
