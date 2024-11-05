module "auto_scaling_group" {
  source = "../../../shared/module/ec2/auto-scaling-group-spot"
  name   = "${local.common_name_prefix}-ecs-asg"

  block_device_name                    = local.workspace["asg"]["block_device_name"]
  block_volume_type                    = local.workspace["asg"]["block_volume_type"]
  block_volume_size                    = local.workspace["asg"]["lt_block_volume_size"]
  cpu_credits                          = local.workspace["asg"]["lt_cpu_credits"]
  disable_api_termination              = local.workspace["asg"]["disable_api_termination"]
  iam_instance_profile_name            = module.ec2_asg_role.profile_name
  image_id                             = local.workspace["asg"]["image_id"]
  instance_initiated_shutdown_behavior = local.workspace["asg"]["instance_initiated_shutdown_behavior"]
  instance_key_name                    = local.workspace["asg"]["instance_key_name"]
  instance_type                        = local.workspace["asg"]["instances_type"][0]
  monitoring_enabled                   = local.workspace["asg"]["lt_monitoring_enabled"]
  tag_instance_resource_type           = local.workspace["asg"]["tag_instance_resource_type"]
  tag_volume_resource_type             = local.workspace["asg"]["tag_volume_resource_type"]
  user_data                            = base64encode(data.template_file.launch_temp_user_data.rendered)
  vpc_security_group_ids               = ["sg-0f84033842322b2eb"]
  capacity_rebalance                   = local.workspace["asg"]["capacity_rebalance"]
  tags = merge(local.common_tags, {
    "Name" = "${local.common_name_prefix}-ecs-asg-instances"
  })
  ebs_optimized = local.workspace["asg"]["ebs_optimized"]

  asg_tags = tolist(concat([
    tomap({
      "key"                 = "Name",
      "value"               = "${local.common_name_prefix}-ecs-asg-instances",
      "propagate_at_launch" = true,
    })
  ], local.asg_common_tags))

  asg_desired_capacity                     = local.workspace["asg"]["asg_desired_capacity"]
  asg_max_capacity                         = local.workspace["asg"]["asg_max_capacity"]
  asg_min_capacity                         = local.workspace["asg"]["asg_min_capacity"]
  aws_launch_template_version              = local.workspace["asg"]["aws_launch_template_version"]
  default_cooldown                         = local.workspace["asg"]["default_cooldown"]
  health_check_grace_period                = local.workspace["asg"]["health_check_grace_period"]
  health_check_type                        = local.workspace["asg"]["health_check_type"]
  subnet_ids                               = data.terraform_remote_state.netwoking.outputs.private_subnet
  on_demand_min_instances                  = local.workspace["asg"]["on_demand_min_instances"]
  on_demand_percentage_above_base_capacity = local.workspace["asg"]["on_demand_percentage_capacity"]
  spot_allocation_strategy                 = local.workspace["asg"]["spot_allocation_strategy"]
  spot_instance_pools                      = local.workspace["asg"]["spot_instance_pools"]
  lifecycle_hook_heartbeat_timeout         = local.workspace["asg"]["lifecycle_hook_heartbeat_timeout"]

  policy_prefix                            = local.service_name_prefix
  scale_in_threshold                       = local.workspace["asg"]["scale_in_threshold"]
  scale_out_threshold                      = local.workspace["asg"]["scale_out_threshold"]
  scaling_in_adjustment                    = local.workspace["asg"]["scaling_in_adjustment"]
  scaling_in_cooldown                      = local.workspace["asg"]["scaling_in_cooldown"]
  scaling_out_adjustment                   = local.workspace["asg"]["scaling_out_adjustment"]
  scaling_out_cooldown                     = local.workspace["asg"]["scaling_out_cooldown"]
  scale_out_evaluation_periods             = local.workspace["asg"]["scale_out_evaluation_periods"]
  scale_in_evaluation_periods              = local.workspace["asg"]["scale_in_evaluation_periods"]
  scale_in_period                          = local.workspace["asg"]["scale_in_period"]
  scale_out_period                         = local.workspace["asg"]["scale_out_period"]
  desired_capacity_type                    = local.workspace["asg"]["desired_capacity_type"]
  instances_type = local.workspace["asg"]["instances_type"]
  throughput = local.workspace["asg"]["throughput"]
  iops =  local.workspace["asg"]["iops"]
  notification_metadata  = "${local.common_name_prefix}-cluster"

}