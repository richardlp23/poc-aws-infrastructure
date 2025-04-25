#VPC with Public and Private Subnets
resource "aws_vpc" "MyVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "genlogs-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "subnet-public2-us-east-1b"
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
    Name = "genlogs-internet-gateway"
  }
}

#Route Table Public
resource "aws_route_table" "public" {
vpc_id = aws_vpc.MyVPC.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
}  
tags = {
    Name = "public-route-table"
  } 
}



