resource "aws_alb" "name" {
  load_balancer_type = var.load_balancer_type
  name               = var.alb_name
  internal           = var.internal
  security_groups    = [aws_security_group.vpc.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  tags = {
    Name        = var.alb_name
    environment = var.environment
  }

}
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_alb.name.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = var.default_action_type
    target_group_arn = aws_alb_target_group.web_tg.arn
  }
  tags = {
    Name        = var.web_listener_name
    environment = var.environment
  }
}
### Target Group ###
resource "aws_alb_target_group" "web_tg" {
  name        = var.web_tg_name
  port        = var.web_tg_port
  protocol    = var.web_tg_protocol
  vpc_id      = aws_vpc.MyVPC.id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    port                = var.health_check_port
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval

  }

  tags = {
    Name        = var.web_tg_name
    environment = var.environment
  }
}
resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  target_group_arn = aws_alb_target_group.web_tg.arn
  target_id        = aws_instance.app-server[0].id
}
resource "aws_lb_target_group_attachment" "web_tg_attachment_2" {
  target_group_arn = aws_alb_target_group.web_tg.arn
  target_id        = aws_instance.app-server[1].id
  port             = 80
}