resource "aws_instance" "app-server-01" {
  ami             = "ami-085ad6ae776d8f09c" # Amazon Linux 2 AMI
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_a.id
  key_name        = "server-key"
  security_groups = [aws_security_group.vpc.id]
  monitoring      = true
  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name        = "web-server-east-1a"
    environment = "development"
  }
}

resource "aws_instance" "app-server-02" {
  ami             = "ami-085ad6ae776d8f09c" # Amazon Linux 2 AMI
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_b.id
  key_name        = "server-key"
  security_groups = [aws_security_group.vpc.id]
  monitoring      = true
  user_data = file("${path.module}/user_data.sh")
  tags = {
    Name        = "web-server-east-1b"
    environment = "development"
  }
}