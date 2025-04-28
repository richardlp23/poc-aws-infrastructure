resource "aws_security_group" "vpc" {
  name   = var.vpc_name
  vpc_id = aws_vpc.MyVPC.id
  tags = {
    Name = var.security_group_name
    env  = var.environment
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["<YOUR_IP_ADDRESS>/32"] # Replace with your IP address
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}