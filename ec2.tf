resource "aws_instance" "app-server" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = var.security_groups
  subnet_id              = aws_subnet.public_b.id
  key_name               = var.key_name
  security_groups        = [aws_security_group.vpc.id]
  monitoring             = true
  user_data              = file("${path.module}/user_data.sh")
  tags = {
    Name        = "${var.ec2_name_prefix} ${count.index + 1}"
    environment = var.environment
  }
} 