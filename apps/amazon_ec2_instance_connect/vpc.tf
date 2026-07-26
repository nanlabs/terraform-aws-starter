data "aws_availability_zones" "available" {
  state = "available"
}

#create VPC if var.vpc_id is empty 
resource "aws_vpc" "main" {
    count                = var.vpc_id == "" ? 1 : 0
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = merge(var.tags, {
        Name = "${var.name}-vpc"
    })
}   

locals {
    target_vpc_id = var.vpc_id != "" ? var.vpc_id : aws_vpc.main[0].id
}
#Subnets
resource "aws_subnet" "private_1" {
    vpc_id                  = local.target_vpc_id
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
    availability_zone       = data.aws_availability_zones.available.names[0]

    tags = merge(var.tags, {
        Name = "${var.name}-private-subnet-1"
    })
}

resource "aws_subnet" "private_2" {
    vpc_id                  = local.target_vpc_id
    cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2)
    availability_zone       = data.aws_availability_zones.available.names[1]

    tags = merge(var.tags, {
        Name = "${var.name}-private-subnet-2"
    })
}

#DB Subnet Group (created if var.db_subnet_group is empty)
resource "aws_db_subnet_group" "created" {
    count  = var.db_subnet_group == "" ? 1 : 0
    name   = "${var.name}-subnet-group"
    subnet_ids = [aws_subnet.private_1.id, 
                    aws_subnet.private_2.id]
                
    tags = merge(var.tags, {
        Name = "${var.name}-subnet-group"
    })
}

locals {
    target_db_subnet_group = var.db_subnet_group != "" ? var.db_subnet_group : (length(aws_db_subnet_group.created) > 0 ? aws_db_subnet_group.created[0].name : "")
}