output "instance_id" {
  value = module.bastion.id
}

output "instance_profile" {
  value = aws_iam_instance_profile.bastion_instance_profile.name
}

output "ssm_parameter_ssh_key" {
  value = length(var.key_name) > 0 ? "" : aws_ssm_parameter.ssh_key[0].name
}
