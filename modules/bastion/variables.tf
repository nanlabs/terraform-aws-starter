variable "vpc_id" {
  description = "VPC id in which the EC2 instance is to be created."
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets in which the EC2 instance is to be created."
  type        = list(string)
}

variable "ami" {
  description = "AMI to use for the instance - will default to latest Ubuntu"
  type        = string
  default     = ""
}

// https://aws.amazon.com/ec2/instance-types/
variable "instance_type" {
  description = "EC2 instance type/size - the default is not part of free tier!"
  type        = string
  default     = "t3.nano"
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp2"
}

variable "allowed_cidrs" {
  description = "Allow these CIDR blocks to instance"
  type        = string
  default     = null
}

variable "key_name" {
  description = "SSH key name to use for the instance"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "create_vpc_endpoints" {
  description = "Create VPC endpoints for SSM, EC2 Messages, and SSM Messages"
  type        = bool
  default     = true
}

variable "vpc_endpoint_security_group_ids" {
  description = "List of security group IDs to attach to the VPC endpoints. Will be ignored if create_vpc_endpoints is false."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}
