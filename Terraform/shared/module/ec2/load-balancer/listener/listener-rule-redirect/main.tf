resource "aws_lb_listener_rule" "http_listner_rule_redirect" {
  listener_arn = var.listner_arn
  priority     = var.priority
  action {
    type = "redirect"
    redirect {
      host        = var.redirect_host_url
      path        = var.redirect_path
      query       = var.redirect_query
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
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