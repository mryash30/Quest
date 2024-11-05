variable "listner_arn" {}
variable "priority" {}
variable "path_pattern" {
  type = list(string)
}
variable "host_header" {
  type = list(string)
}
variable "target_group_arn_1" {}
variable "target_group_arn_2" {}
variable "target_group_weight_1" {}
variable "target_group_weight_2" {}
variable "target_group_type" {}
