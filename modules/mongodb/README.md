# MongoDB Atlas Module

This module creates a MongoDB Atlas cluster and configures a VPC peering connection between the Atlas cluster and the specified VPC.

## Usage

```hcl
provider "aws" {
  region = "eu-west-1"
}

provider "mongodbatlas" {}


module "atlas_cluster" {
  source = "../../modules/mongodb"

  project_name = "my-project"
  org_id       = "5edf67f9b9614996228111"

  teams = {
    Devops : {
      users : ["example@mail.io", "user@mail.io"]
      role : "GROUP_OWNER"
    },
    DevTeam : {
      users : ["developer@mail.io"]
      role : "GROUP_READ_ONLY"
    }
  }

  access_lists = {
    "example comment" : "52.12.41.46/32",
    "second example" : "54.215.4.201/32"
  }

  region = "EU_WEST_1"

  cluster_name = "MyCluster"

  instance_type      = "M30"
  mongodb_major_ver  = 4.2
  cluster_type       = "REPLICASET"
  num_shards         = 1
  replication_factor = 3
  provider_backup    = true
  pit_enabled        = false

  vpc_peer = {
    vpc_peer1 : {
      aws_account_id : "020201234877"
      region : "eu-west-1"
      vpc_id : "vpc-0240c8a47312svc3e"
      route_table_cidr_block : "172.16.0.0/16"
    },
    vpc_peer2 : {
      aws_account_id : "0205432147877"
      region : "eu-central-1"
      vpc_id : "vpc-0f0dd82430bhv0e1a"
      route_table_cidr_block : "172.17.0.0/16"
    }
  }
}
```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
