variable "enable_bastion" {
  type        = bool
  description = "Enable bastion host"
  default     = false
}

module "bastion" {
  count = var.enable_bastion ? 1 : 0

  source          = "../../modules/bastion"
  name            = "${module.label.id}-bastion"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  instance_type   = "t2.micro"
  tags            = module.label.tags
}

output "bastion_instance_id" {
  value = var.enable_bastion ? module.bastion[0].instance_id : null
}

output "bastion_instance_profile" {
  value = var.enable_bastion ? module.bastion[0].instance_profile : null
}

output "ssm_parameter_bastion_ssh_key" {
  description = "name of the ssm parameter for the bastion ssh key"
  value       = var.enable_bastion ? module.bastion[0].ssm_parameter_ssh_key : null
}
