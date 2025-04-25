resource "aws_alb" "name" {
  load_balancer_type = "application"
  name               = "genlogs-aws-alb"
  internal           = false
  security_groups    = [aws_security_group.vpc.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id] # List of subnet IDs
  tags = {
    Name        = "genlogs-aws-alb"
    environment = "development"
    service     = "web"
  }

}
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_alb.name.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web_tg.arn
  }
  tags = {
    Name        = "web-listener"
    environment = "development"
  }
}
### Target Group ###
resource "aws_alb_target_group" "web_tg" {
  name        = "genlogs-tg-ue1"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.MyVPC.id
  target_type = "instance"
  
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 4
    interval            = 5
  }
  
  tags = {
    Name        = "web-tg"
    environment = "development"
  }
}
resource aws_lb_target_group_attachment "web_tg_attachment" {
  target_group_arn = aws_alb_target_group.web_tg.arn
  target_id        = aws_instance.app-server-01.id
  port             = 80
}
resource aws_lb_target_group_attachment "web_tg_attachment_2" {
  target_group_arn = aws_alb_target_group.web_tg.arn
  target_id        = aws_instance.app-server-02.id
  port             = 80
}