variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Force bucket deletion"
  type        = bool
  default     = false
}

variable "acl" {
  description = "Canned ACL to apply to the bucket"
  type        = string
  default     = "private"
}

variable "enable_versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "KMS key for bucket encryption"
  type        = string
  default     = "alias/aws/s3"
}

variable "enable_lifecycle_rule" {
  description = "Enable lifecycle rule"
  type        = bool
  default     = true
}

variable "lifecycle_transition_days" {
  description = "Number of days after which to transition objects"
  type        = number
  default     = 30
}

variable "lifecycle_storage_class" {
  description = "Storage class for lifecycle transition"
  type        = string
  default     = "GLACIER"
}

variable "lifecycle_expiration_days" {
  description = "Number of days after which to expire objects"
  type        = number
  default     = 90
}

variable "logging_bucket" {
  description = "Bucket for storing logs"
  type        = string
}
