/* VPC */
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Environment = var.environment
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Environment = var.environment
  }
}

/* Elastic IP for NAT gateway */
resource "aws_eip" "my_nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.my_ig]
  tags = {
    Environment = var.environment
  }
}

/* NAT gateway */
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.my_public_subnet.id
  depends_on    = [aws_internet_gateway.my_ig]
  tags = {
    Environment = var.environment
  }
}

