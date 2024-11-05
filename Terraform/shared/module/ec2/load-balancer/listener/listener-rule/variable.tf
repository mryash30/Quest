variable "listner_arn" {}
variable "priority" {}
variable "path_pattern" {
  type = list(string)
}
variable "host_header" {
  type = list(string)
}
variable "target_group_arn" {}
variable "target_group_type" {}
