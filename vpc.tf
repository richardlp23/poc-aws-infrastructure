#VPC with Public and Private Subnets
resource "aws_vpc" "MyVPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = var.subnet_public_a_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone_a
  tags = {
    Name = var.subnet_public_a_name
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = var.subnet_public_b_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone_b
  tags = {
    Name = var.subnet_public_b_name
  }
}

#associate public subnets with route table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

#internet gateway  
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.MyVPC.id
  tags = {
    Name = var.internet_gateway_name
  }
}

#Route Table Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = var.route_table_name
    env  = var.environment
  }
}



