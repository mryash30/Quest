variable "is_private_load_balancer" {}
variable "name" {}
variable "idle_timeout" {}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {}
variable "load_balancer_type" {}
variable "enable_deletion_protection" {}
variable "log_bucket_name" {}
variable "log_bucket_prefix" {}
variable "tags" {}
variable "log_enable" {}
variable "drop_invalid_header_fields" { default = false }
variable "preserve_host_header" {
  default = false
}