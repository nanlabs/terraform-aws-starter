# DocumentDB Module

Terrform module to bootstrap a DocumentDB cluster.

## Usage

```hcl
module "db" {
  source = "../../modules/docdb"

  name = "examples-docdb-cluster"

  vpc_id       = module.vpc.vpc_id
  subnet_group = module.vpc.database_subnet_group

  db_name            = "db_name"
  db_master_username = "db_master_username"

  instance_class = "db.t3.medium"
  cluster_size   = 2
}

```

## Module Documentation

The module documentation is generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs) by running `terraform-docs md . > ./docs/MODULE.md` from the module directory.

You can also view the latest version of the module documentation [here](./docs/MODULE.md).
