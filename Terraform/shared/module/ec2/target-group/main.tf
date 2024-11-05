resource "aws_lb_target_group" "target_group" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  target_type          = var.target_type
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  health_check {
    path                = var.health_check_path
    protocol            = lookup(var.health_check, "check_protocol")
    port                = lookup(var.health_check, "check_port")
    healthy_threshold   = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    timeout             = lookup(var.health_check, "timeout")
    interval            = lookup(var.health_check, "interval")
    matcher             = lookup(var.health_check, "http_status")
  }
  tags = var.tags
}
