# load balancer listener
variable "vpc_id" {}
variable "name" {}
variable "td_name" {}
variable "deregistration_delay" {}
variable "slow_start" {}
variable "health_check" {
  type = object({
    check_protocol      = string
    check_port          = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    http_status         = string
  })
}
variable "protocol" {}
variable "target_type" {}
variable "port" {}
variable "health_check_path" {}
variable "expression"{}
variable "type"{}

variable "enable_placement_constraints"{}

# Task defination
variable "container_definitions" {}

variable "ecs_task_role_arn" {
  default = ""
}
variable "ecs_execution_role_arn" {
  default = ""
}
variable "network_mode" {
  default = "bridge"
}
variable "requires_compatibilities" {
  default = "EC2"
}
variable "host_log" {
  type    = string
  default = ""
}
variable "host_log_path" {
  type    = string
  default = ""
}
variable "host_log_1" {
  type    = string
  default = ""
}
variable "host_log_path_1" {
  type    = string
  default = ""
}
variable "enable_execute_command" {
  default = false
}
variable "enable_circuit_breaker" {
  default = false
}
variable "rollback_ecs" {
  default = false
}

# Service
variable "tags" {
  type = map(string)
}
variable "ecs_task_desired_count" {
  type    = number
  default = 0
}
variable "ecs_cluster_id" {}
variable "health_check_grace_period_seconds" {}
variable "exposed_ecs_container_name" {}
variable "exposed_ecs_container_port" {}
variable "ecs_service_role_arn" {}
variable "deployment_minimum_healthy_percent" {}
variable "deployment_maximum_percent" {}
variable "launch_type" {
  default = "EC2"
}
variable "scheduling_strategy" {
  default = "REPLICA"
}
variable "enable_ecs_managed_tags" {
  default = true
}