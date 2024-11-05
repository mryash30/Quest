resource "aws_launch_template" "launch_template" {
  name = var.name

  ebs_optimized = var.ebs_optimized

  disable_api_termination = var.disable_api_termination

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  image_id                             = var.image_id
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  key_name                             = var.instance_key_name

  monitoring {
    enabled = var.monitoring_enabled
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  tags = var.tags

  user_data = var.user_data

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = var.tag_instance_resource_type
    tags          = var.tags
  }

  tag_specifications {
    resource_type = var.tag_volume_resource_type
    tags          = var.tags
  }

  block_device_mappings {
    device_name = var.block_device_name
    ebs {
      volume_type           = var.block_volume_type
      volume_size           = var.block_volume_size
      encrypted             = true
      delete_on_termination = true
      throughput            = var.throughput
      iops                  = var.iops
    }
  }
}

resource "aws_autoscaling_group" "asg-spot" {
  name                      = var.name
  max_size                  = var.asg_max_capacity
  min_size                  = var.asg_min_capacity
  health_check_grace_period = var.health_check_grace_period
  default_cooldown          = var.default_cooldown
  health_check_type         = var.health_check_type
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  capacity_rebalance        = var.capacity_rebalance
  desired_capacity_type     = var.desired_capacity_type
  termination_policies = ["OldestInstance"]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
  "GroupTotalInstances"]

  timeouts {
    delete = "15m"
  }

  dynamic "tag" {
    for_each = var.asg_tags
    content {
      key                 = tag.value.key
      propagate_at_launch = tag.value.propagate_at_launch
      value               = tag.value.value
    }
  }
  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy            = var.on_demand_allocation_strategy
      on_demand_base_capacity                  = var.on_demand_min_instances
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.spot_allocation_strategy
      spot_instance_pools                      = var.spot_instance_pools
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.launch_template.id
        version            = var.aws_launch_template_version
      }
      dynamic "override" {
        for_each = var.instances_type
        content {
          instance_type = override.value
          weighted_capacity = 1
        }
      }
    }
  }
}

resource "aws_autoscaling_lifecycle_hook" "spot_asg_hook" {
  name                    = "${var.name}-instance-termination-hook"
  autoscaling_group_name  = aws_autoscaling_group.asg-spot.name
  default_result          = var.lifecycle_hook_default_result
  heartbeat_timeout       = var.lifecycle_hook_heartbeat_timeout
  lifecycle_transition    = var.lifecycle_hook_transition
  # notification_target_arn = aws_sns_topic.lifecycle_hook_topic.arn
  # role_arn                = aws_iam_role.iam_role.arn
  notification_metadata  = var.notification_metadata
  }
