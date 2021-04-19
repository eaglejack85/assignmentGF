/* Public subnets */
resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.azs.names[1]
  map_public_ip_on_launch = true
  tags = {
    Environment = var.environment
  }
}

resource "aws_subnet" "my_public_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr2
  availability_zone       = data.aws_availability_zones.azs.names[2]
  map_public_ip_on_launch = true
  tags = {
    Environment = var.environment
  }
}

/* Private subnet */
resource "aws_subnet" "my_private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = false
  tags = {
    Environment = var.environment
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "my_private_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Environment = var.environment
  }
}

/* Routing table for public subnets */
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Environment = var.environment
  }
}

resource "aws_route" "my_public_ig_route" {
  route_table_id         = aws_route_table.my_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_ig.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.my_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat.id
}

/* Route table associations */
resource "aws_route_table_association" "my_public_rta" {
  subnet_id      = aws_subnet.my_public_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
}
resource "aws_route_table_association" "my_public2_rta" {
  subnet_id      = aws_subnet.my_public_subnet2.id
  route_table_id = aws_route_table.my_public_rt.id
}
resource "aws_route_table_association" "my_private_rta" {
  subnet_id      = aws_subnet.my_private_subnet.id
  route_table_id = aws_route_table.my_public_rt.id
}