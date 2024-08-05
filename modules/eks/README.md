# EKS

Terraform module to provision an EKS cluster using the CloudPosse EKS module.

## Usage

```hcl
module "eks" {
  source = "../../modules/eks"

  name            = "my-eks-cluster"

  region                  = "us-east-1"
  vpc_id                  = "vpc-xxxxxxxx"
  private_subnets         = ["subnet-xxxxxxxx", "subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  public_subnets          = ["subnet-xxxxxxxx", "subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  kubernetes_version      = "1.30"
  tags                    = {
    Environment = "production"
  }
  oidc_provider_enabled   = true
  private_ipv6_enabled    = false
  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  cluster_log_retention_period = 90
  cluster_encryption_config_enabled = true
  cluster_encryption_config_kms_key_id = "arn:aws:kms:us-east-1:xxxxxxxxxx:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  cluster_encryption_config_kms_key_enable_key_rotation = true
  cluster_encryption_config_kms_key_deletion_window_in_days = 30
  cluster_encryption_config_kms_key_policy = ""
  cluster_encryption_config_resources = ["secrets"]
  allowed_security_group_ids = ["sg-xxxxxxxx"]
  allowed_cidr_blocks        = ["10.0.0.0/16"]

  addons = [
    {
      addon_name    = "vpc-cni"
      addon_version = null
    },
    {
      addon_name    = "kube-proxy"
      addon_version = null
    },
    {
      addon_name    = "coredns"
      addon_version = null
    }
  ]

  node_groups = [
    {
      instance_types          = ["m5.large"]
      min_size                = 3
      max_size                = 6
      desired_size            = 4
      health_check_type       = "EC2"
      kubernetes_labels       = {
        environment = "production"
      }
    }
  ]
}
