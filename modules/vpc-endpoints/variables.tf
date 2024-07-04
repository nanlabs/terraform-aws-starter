variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "endpoints" {
  description = "A map of VPC endpoint configurations to create."
  type        = any
  default     = {}
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the endpoints"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the endpoints"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
