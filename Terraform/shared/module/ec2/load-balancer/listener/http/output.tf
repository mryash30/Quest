output "http_listner_arn" {
  value = flatten([aws_lb_listener.default_http_listner[*].arn])
}
output "http_listner_arn1" {
  value = aws_lb_listener.default_http_listner1[*].arn
}

output "http_listner_id" {
  value = aws_lb_listener.default_http_listner[*].id
}
