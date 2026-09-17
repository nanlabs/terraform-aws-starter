# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]



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

[Unreleased]: https://github.com/nanlabs/terraform-aws-modules/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.4.0
[0.3.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.3.0
[0.2.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.2.0
[0.1.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.1.0
