# General settings

region      = "us-west-2"
name        = "core-networking"
namespace   = "nan"
environment = "sandbox"
tags        = {}

# Resources settings

vpc_cidr_block = "10.0.0.0/16"
enable_bastion = true

cluster_name = "nan-sandbox-services-platform-cluster"
