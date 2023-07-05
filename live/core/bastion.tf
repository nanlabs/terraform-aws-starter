module "bastion" {
  source                       = "../../modules/bastion"
  name                         = module.label.id
  region                       = var.region
  vpc_id                       = module.vpc.vpc_id
  subnets                      = module.vpc.public_subnets
  associate_public_ip_address  = true
  associate_elastic_ip_address = false
  tags                         = module.label.tags
}

output "bastion_instance_id" {
  value = module.bastion.instance_id
}

output "bastion_instance_profile" {
  value = module.bastion.instance_profile
}

output "bastion_ssh_command" {
  value = module.bastion.ssh_command
}

output "ssm_parameter_bastion_ssh_key" {
  description = "name of the ssm parameter for the bastion ssh key"
  value       = module.bastion.ssm_parameter_ssh_key
}
