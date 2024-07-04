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
  instance_type                = "t2.micro"
  associate_public_ip_address  = true
  associate_elastic_ip_address = false
  tags                         = module.label.tags
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
