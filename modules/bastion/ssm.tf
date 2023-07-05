resource "aws_ssm_parameter" "ssh_key" {
  count = length(var.key_name) > 0 ? 0 : 1

  name  = "/${var.name}/bastion_ssh"
  type  = "SecureString"
  value = local_file.private_key[0].content
}
