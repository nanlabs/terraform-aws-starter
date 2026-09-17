# TFlint configuration: core rules only, no provider plugins.
#
# The full provider rulesets (e.g. tflint-ruleset-aws) must be downloaded
# from GitHub Releases by `tflint --init`, and that download fails inside
# the MegaLinter CI job with `401 Bad credentials` (persistent since
# 2026-09-04, main runs 33832608378 and 34555141751), so any declared
# plugin breaks the gate regardless of the codebase. Keep this file
# plugin-free until the runner -> api.github.com auth issue is resolved;
# then re-add:
#   plugin "aws" {
#     enabled = true
#     version = "0.48.0"
#     source  = "github.com/terraform-linters/tflint-ruleset-aws"
#   }
config {
  # `tflint --init` is a no-op without plugins: nothing to download.
  plugin_dir = "./.tflint.d/plugins"
}

# Reusable modules expose inputs/outputs as their public interface, so
# "declared but not used" is the norm, not a finding (110 warnings across
# modules and examples). Keep the rule off; every other core rule stays on.
rule "terraform_unused_declarations" {
  enabled = false
}
