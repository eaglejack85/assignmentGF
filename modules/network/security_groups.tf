/* VPC's Default Security Group */
resource "aws_security_group" "my_vpc_sg" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.my_vpc.id
  depends_on  = [aws_vpc.my_vpc]
  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "my_vpc_public_gr_ingress_https" {
  type              = "ingress"
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_subnet.my_public_subnet.cidr_block,aws_subnet.my_public_subnet2.cidr_block]
  security_group_id = aws_security_group.my_vpc_sg.id
}

resource "aws_security_group_rule" "my_vpc_public_gr_ingress_http" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [aws_subnet.my_public_subnet.cidr_block,aws_subnet.my_public_subnet2.cidr_block]
  security_group_id = aws_security_group.my_vpc_sg.id
}

resource "aws_security_group_rule" "my_vpc_private_gr_ingress_ssh" {
  type              = "ingress"
  from_port         = 0
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_subnet.my_private_subnet.cidr_block]
  security_group_id = aws_security_group.my_vpc_sg.id
}

resource "aws_security_group_rule" "my_vpc_public_gr_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [aws_subnet.my_public_subnet.cidr_block,aws_subnet.my_public_subnet2.cidr_block]
  security_group_id = aws_security_group.my_vpc_sg.id
}

resource "aws_security_group_rule" "my_vpc_private_gr_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [aws_subnet.my_private_subnet.cidr_block]
  security_group_id = aws_security_group.my_vpc_sg.id
}