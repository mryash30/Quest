variable "vpc_id" {
}
variable "name" {
}
variable "deregistration_delay" {
}
variable "tags" {
  type = map(string)
}
variable "health_check" {
  type = object({
    check_protocol      = string
    check_port          = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    http_status         = number
  })
}
variable "protocol" {
}
variable "target_type" {
}
variable "port" {}
variable "health_check_path" {}
