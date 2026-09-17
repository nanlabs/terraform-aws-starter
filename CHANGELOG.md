# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Consume shared library `v1.19.0` across all pinned callers (vpc, bastion, rds, eks, iam-role)


## [0.13.0] - 2026-09-17
### Changed
- Consume shared library `v1.19.0` across all pinned callers (vpc, bastion, rds, eks, iam-role)



## [0.12.0] - 2026-09-17



## [0.11.0] - 2026-09-17



## [0.10.0] - 2026-09-17



## [0.9.0] - 2026-09-17



## [0.8.0] - 2026-09-17



## [0.7.0] - 2026-09-17



## [0.6.0] - 2026-09-17



## [0.5.0] - 2026-09-17



## [0.4.0] - 2026-09-17



## [0.3.0] - 2026-09-17



## [0.2.0] - 2026-09-17
### Changed
- `live/core-networking`: consume `nanlabs/terraform-aws-modules//modules/aws-vpc?ref=v1.18.0` instead of the local `modules/vpc` wrapper (upstream `vpc/aws` 5.0.0 → 6.7.2, app SG `security-group` v4 → v6); same subnet CIDRs and SSM parameter names, state adopted in place (VPC/SSM paths unchanged, app SG via the library's `moved` block)
- Removed local `modules/vpc` (superseded by the shared library); `modules/vpc-endpoints` stays local
- `live/core-networking`: consume `nanlabs/terraform-aws-modules//modules/aws-bastion?ref=v1.18.0` instead of local `modules/bastion`; instance, key pair, AMI, user-data and SG paths unchanged (adopted in place), SSH key material preserved. Deltas when enabled: root volume `gp2` → `gp3`, three per-endpoint SGs consolidated into one, SSM key param `/{name}/bastion_ssh` → `/{name}/ssh_private_key`
- Removed local `modules/bastion` (superseded by the shared library)
- Removed unreferenced local modules superseded by the shared library: `modules/docdb` (→ `aws-docdb`), `modules/msk` (→ `aws-msk`), `modules/rds-aurora` (→ `aws-rds-aurora`), `modules/mongodb` (→ `mongodb-atlas-cluster`), `modules/amplify-app` (→ `aws-amplify-app`); README module table now points at the library
- `live/aws-iam-management`: consume `nanlabs/terraform-aws-modules//modules/aws-iam-role?ref=v1.18.0` instead of local `modules/iam-role` (verified byte-identical: same resources, variables and outputs, state adopted in place); removed the local module
- `live/common-infra`: example DB consumes `nanlabs/terraform-aws-modules//modules/aws-rds?ref=v1.18.0` instead of local `modules/rds` (upstream `rds/aws` 6.1.1 → 7.2.1, managed master password so no `password_wo` needed); same engine/storage/backup/monitoring settings passed explicitly, `example_db_instance_address` keeps the bare hostname contract; removed the local module (including its dead `vpc_id` variable)
- `live/services-platform`: consume `nanlabs/terraform-aws-modules//modules/aws-eks?ref=v1.18.0` instead of local `modules/eks` (cluster 4.2.0 → 4.15.0, node groups 3.0.1 → 3.4.0; upstream inventories diffed, existing resources only gain opt-in additions); stack keeps the `node_groups` list interface and converts to the library map with numeric keys preserving state addresses; removed the local module
- Inline `security-group` 4.x → `~> 6.0` with structured rules (`live/common-infra` example DB SG, `live/core-networking` endpoint SGs); output refs updated (`security_group_id` → `id`). The v6 fixed names replace the v4 name-prefix SGs on next apply (stateless, no data loss)
- Fixed `apps/amazon_ec2_instance_connect` (missing resource instance keys, undeclared `deletion_protection`, `name_prefix` → `name`; floors raised to TF `>= 1.11` / AWS `>= 6.0`) and extended the Validation workflow with an apps matrix so `apps/*` is validated like `live/*` and `modules/*`
- README: new `Starter Kit vs Shared Library` section (bidirectional reference to the library, STARTER_COMPATIBILITY and PR nanlabs/terraform-aws-modules#72); corrected CI docs (Trivy instead of tfsec)
- `live/services-platform`: `ecr/aws` 2.3.0 → 3.2.0 (breaking changes limited to provider MSV and new filters; interface used unchanged)
- Hardening from the Trivy register: example RDS is now private (`publicly_accessible = false`, was inherited `true`), EKS envelope encryption on by default, example DB SG egress scoped to the VPC CIDR; residual findings (EKS public endpoint, app-SG egress, state-bucket CMK) recorded as accepted reference-arch tradeoffs in `trivy.yml`
- CI toolchain currency: `setup-node` v4 → v7, `pnpm/action-setup` v4 → v6, `terraform-docs/gh-actions` 1.2.0 → 1.4.1, `todo-to-issue-action` v4 → v5, `danger` 13 → 14, `typescript` stays on 5.x (7.0 dropped: its native rewrite removes `ts.transpileModule`, which danger needs at runtime)


## [0.1.0] - 2026-09-17
### Added
- CI parity with `terraform-aws-modules`: Terraform Validation workflow (fmt + init + validate for `live/*` and `modules/*`), MegaLinter baseline, Dependabot (terraform, github-actions, npm), automated releases, Trivy HIGH/CRITICAL scan replacing deprecated tfsec
- `.terraform-version` (1.12.1) and `CHANGELOG.md`

### Changed
- Raised floors to `required_version >= 1.11` and AWS provider `>= 6.0`; refreshed all lockfiles
- `modules/bastion`: `ec2-instance` 3.x → 6.4.0 (object `root_block_device`, exact IAM attachments instead of deprecated `managed_policy_arns`)

### Fixed
- `live/common-infra`: added missing `database_subnet_group` SSM lookup, fixed `aws_vpc` reference in RDS example
- Repository-wide `terraform fmt` clean

[Unreleased]: https://github.com/nanlabs/terraform-aws-modules/compare/v0.13.0...HEAD
[0.13.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.13.0
[0.12.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.12.0
[0.11.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.11.0
[0.10.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.10.0
[0.9.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.9.0
[0.8.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.8.0
[0.7.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.7.0
[0.6.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.6.0
[0.5.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.5.0
[0.4.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.4.0
[0.3.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.3.0
[0.2.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.2.0
[0.1.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.1.0
