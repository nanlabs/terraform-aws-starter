resource "aws_ec2_instance_connect_endpoint" "eic" {

  subnet_id = aws_subnet.private_1.id
  security_group_ids = [aws_security_group.eic_sg.id]

  tags = merge(var.tags, {
    Name = "${var.name}-eic-endpoint"
  })
}