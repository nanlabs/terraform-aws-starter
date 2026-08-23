# Security Group for EC2 Instance Connect Endpoint
resource "aws_security_group" "eic_sg" {
  name        = "${var.name}-eic-endpoint-sg"
  description = "Security group for EC2 Instance Connect Endpoint"
  vpc_id      = local.target_vpc_id


  tags = merge(var.tags, {
    Name = "${var.name}-eic-sg"
  })
}

# Security Group for RDS Instance
resource "aws_security_group" "rds_sg" {
  name        = "${var.name}-rds-sg"
  description = "Security group for private RDS instance"
  vpc_id      = local.target_vpc_id


  tags = merge(var.tags, {
    Name = "${var.name}-rds-sg"
  })
}

# Separate rule: Allow EIC Endpoint egress to RDS Security Group
resource "aws_security_group_rule" "eic_egress_to_rds" {
  type                     = "egress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eic_sg.id
  source_security_group_id = aws_security_group.rds_sg.id
  description              = "Allow egress to RDS on database port"
}

# Separate rule: Allow RDS ingress from EIC Endpoint Security Group
resource "aws_security_group_rule" "rds_ingress_from_eic" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.eic_sg.id
  description              = "Allow access from EC2 Instance Connect Endpoint"
}