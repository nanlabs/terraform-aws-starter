# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]



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

[Unreleased]: https://github.com/nanlabs/terraform-aws-modules/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/nanlabs/terraform-aws-modules/releases/tag/v0.1.0
