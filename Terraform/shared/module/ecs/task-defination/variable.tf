variable "container_definitions" {}

variable "task_def_name" {}
variable "tags" {
  type = map(string)
}
variable "ecs_task_role_arn" {
  default = ""
}
variable "network_mode" {
  default = "bridge"
}
variable "requires_compatibilities" {
  default = "EC2"
}

variable "host_log" {
}
variable "host_log_path" {
}
variable "host_log_1" {
}
variable "host_log_path_1" {
}
variable "ecs_execution_role_role" {
}