resource "aws_lb_listener_rule" "http_listner_rule" {
  listener_arn = var.listner_arn
  priority     = var.priority
  action {
    type = "forward"
    forward {
      target_group {
        arn    = var.target_group_arn_1
        weight = var.target_group_weight_1
      }

      target_group {
        arn    = var.target_group_arn_2
        weight = var.target_group_weight_2
      }
    }
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
