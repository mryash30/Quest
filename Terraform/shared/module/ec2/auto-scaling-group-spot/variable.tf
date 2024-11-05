# launch template
variable "name" {}
variable "cpu_credits" {}
variable "disable_api_termination" {}
variable "iam_instance_profile_name" {}
variable "instance_initiated_shutdown_behavior" {}
variable "instance_type" {}
variable "instance_key_name" {}
variable "monitoring_enabled" {}
variable "vpc_security_group_ids" {
  type = set(string)
}
variable "tags" {
  type = map(string)
}
variable "asg_tags" {
  type = list(map(string))
}
variable "tag_instance_resource_type" {}
variable "tag_volume_resource_type" {}
variable "block_device_name" {}
variable "block_volume_type" {}
variable "block_volume_size" {}
variable "image_id" {}
variable "user_data" {}
variable "ebs_optimized" {}

# Auto scalling group
variable "subnet_ids" {
  type = list(string)
}
variable "asg_desired_capacity" {}
variable "health_check_type" {}
variable "default_cooldown" {}
variable "health_check_grace_period" {}
variable "asg_min_capacity" {}
variable "asg_max_capacity" {}
variable "aws_launch_template_version" {}
variable "on_demand_min_instances" {}
variable "on_demand_percentage_above_base_capacity" {}
variable "spot_allocation_strategy" {
  type    = string
  default = "lowest-price"
}
variable "on_demand_allocation_strategy" {
  type    = string
  default = "prioritized"
}
variable "spot_instance_pools" {
  type    = number
  default = 2
}

# Auto scalling policy
variable "policy_prefix" {}
variable "scaling_in_adjustment" {
  type = number
}
variable "scaling_in_cooldown" {
  type = number
}
variable "scaling_out_adjustment" {
  type = number
}
variable "scaling_out_cooldown" {
  type = number
}
variable "scale_in_threshold" {
  type = number
}
variable "scale_out_threshold" {
  type = number
}
variable "scale_out_evaluation_periods" {
  type = number
}
variable "scale_in_evaluation_periods" {
  type = number
}
variable "scale_in_period" {
  type = number
}
variable "scale_out_period" {
  type = number
}

variable "instances_type" {
  type = list(string)
}

variable "sns_sqs_access" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}
variable "lifecycle_hook_transition" {
  type    = string
  default = "autoscaling:EC2_INSTANCE_TERMINATING"
}
variable "lifecycle_hook_heartbeat_timeout" {
  type    = number
  default = 300
}
variable "lifecycle_hook_default_result" {
  type    = string
  default = "CONTINUE"
}

# Auto scaling notification

variable "capacity_rebalance" {
  type = bool
  default = true
}

variable "throughput" {}
variable "iops" {}


variable "desired_capacity_type" {}
variable "notification_metadata" {}