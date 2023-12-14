locals {
  bastion = {
    enable = true
  }
}

module "bastion" {
  count = local.bastion.enable ? 1 : 0

  source                       = "../../../../modules/bastion"
  name                         = "${module.label.id}-bastion"
  vpc_id                       = module.vpc.vpc_id
  subnets                      = module.vpc.public_subnets
  associate_public_ip_address  = true
  associate_elastic_ip_address = true
  tags                         = module.label.tags
}

output "bastion_instance_id" {
  value = local.bastion.enable ? module.bastion[0].instance_id : null
}

output "bastion_instance_profile" {
  value = local.bastion.enable ? module.bastion[0].instance_profile : null
}

output "ssm_parameter_bastion_ssh_key" {
  description = "name of the ssm parameter for the bastion ssh key"
  value       = local.bastion.enable ? module.bastion[0].ssm_parameter_ssh_key : null
}
