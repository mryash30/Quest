output "https_listner_arn" {
  value = aws_lb_listener.default_https_listner.arn
}

output "https_listner_id" {
  value = aws_lb_listener.default_https_listner.id
}
