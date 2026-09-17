variable "enable_bastion" {
  type        = bool
  description = "Enable bastion host"
  default     = false
}

module "bastion" {
  count = var.enable_bastion ? 1 : 0

  source = "git::https://github.com/nanlabs/terraform-aws-modules.git//modules/aws-bastion?ref=v1.18.0"

  name             = "${module.label.id}-bastion"
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  instance_type    = "t2.medium"
  root_volume_size = 32
  tags             = merge(module.label.tags, { "Name" = "${module.label.id}-bastion" })
}

output "bastion_instance_id" {
  value = var.enable_bastion ? module.bastion[0].instance_id : null
}

output "bastion_instance_profile" {
  value = var.enable_bastion ? module.bastion[0].iam_instance_profile_name : null
}

output "ssm_parameter_bastion_ssh_key" {
  description = "name of the ssm parameter for the bastion ssh private key"
  value       = var.enable_bastion ? module.bastion[0].ssm_parameter_names["ssh_private_key"] : null
}
