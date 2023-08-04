resource "aws_ssm_parameter" "ssh_key" {
  count = length(var.key_name) > 0 ? 0 : 1

  name  = "/${var.name}/bastion_ssh"
  type  = "SecureString"
  value = tls_private_key.ec2_ssh[0].private_key_pem
}
