resource "aws_lb_listener_rule" "http_listner_rule" {
  listener_arn = var.listner_arn
  priority     = var.priority
  action {
    type             = var.target_group_type
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = var.path_pattern
    }
  }

  condition {
    host_header {
      values = var.host_header
    }
  }
}
