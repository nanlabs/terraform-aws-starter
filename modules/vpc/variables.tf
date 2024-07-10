variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC to use. Leave blank to create a new VPC."
  type        = string
  default     = ""
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block to use if creating a new VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateways for each private subnet"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all private subnets"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Any extra tags to assign to objects"
  type        = map(any)
  default     = {}
}

variable "azs_count" {
  description = "Number of Availability Zones to use. This value is used to determine the number of public and private subnets to create."
  type        = number
  default     = 3
}

variable "public_subnet_tags" {
  description = "Any extra tags to assign to public subnets"
  type        = map(any)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Any extra tags to assign to private subnets"
  type        = map(any)
  default     = {}
}
