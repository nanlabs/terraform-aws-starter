variable "enable_bastion" {
  type        = bool
  description = "Enable bastion host"
  default     = false
}

module "bastion" {
  count = var.enable_bastion ? 1 : 0

  source                       = "../../modules/bastion"
  name                         = "${module.label.id}-bastion"
  vpc_id                       = module.vpc.vpc_id
  subnets                      = module.vpc.public_subnets
  associate_public_ip_address  = true
  associate_elastic_ip_address = false
  tags                         = module.label.tags
}

# Compute the name of the .pem file based on your naming convention
locals {
  bastion_ssh_key_name = var.enable_bastion ? "${module.label.id}-bastion-ec2-ssh-key.pem" : null
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

output "bastion_ssh_key_name" {
  description = "Name of the .pem file for the bastion SSH key"
  value       = local.bastion_ssh_key_name
}