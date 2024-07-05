locals {
  disable_key_creation = length(var.key_name) > 0
}

// Create EC2 ssh key pair
resource "tls_private_key" "ec2_ssh" {
  count = local.disable_key_creation ? 0 : 1

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_ssh" {
  count = local.disable_key_creation ? 0 : 1

  key_name   = "${var.name}-ec2-ssh-key"
  public_key = tls_private_key.ec2_ssh[0].public_key_openssh
}
