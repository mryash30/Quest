variable "listner_arn" {}
variable "priority" {}
variable "path_pattern" {
  type = list(string)
}
variable "host_header" {
  type = list(string)
}
variable "redirect_host_url" {}
variable "redirect_path" {}
variable "redirect_query" {}
