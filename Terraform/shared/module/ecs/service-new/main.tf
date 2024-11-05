resource "aws_lb_target_group" "target_group" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  target_type          = var.target_type
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start
  health_check {
    path                = var.health_check_path
    protocol            = lookup(var.health_check, "check_protocol")
    port                = lookup(var.health_check, "check_port")
    healthy_threshold   = lookup(var.health_check, "healthy_threshold")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    timeout             = lookup(var.health_check, "timeout")
    interval            = lookup(var.health_check, "interval")
    matcher             = lookup(var.health_check, "http_status")
  }
  tags = var.tags
}

resource "aws_ecs_task_definition" "task" {
  family       = var.td_name
  network_mode = var.network_mode
  requires_compatibilities = [
  var.requires_compatibilities]
  container_definitions = var.container_definitions
  task_role_arn         = var.ecs_task_role_arn
  execution_role_arn = var.ecs_execution_role_arn
  tags                  = var.tags
  dynamic "volume" {
    for_each = var.host_log == "" ? [] : [1]
    content {
      name      = var.host_log
      host_path = var.host_log_path
    }
  }
  dynamic "volume" {
    for_each = var.host_log_1 == "" ? [] : [1]
    content {
      name      = var.host_log_1
      host_path = var.host_log_path_1
    }
  }
}

resource "aws_ecs_service" "service" {
  name                               = var.name
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.task.arn
  desired_count                      = var.ecs_task_desired_count
  iam_role                           = var.ecs_service_role_arn
  launch_type                        = var.launch_type
  scheduling_strategy                = var.scheduling_strategy
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  tags                               = var.tags
  enable_execute_command             = var.enable_execute_command
  propagate_tags = "SERVICE"

  deployment_circuit_breaker {
    enable   = var.enable_circuit_breaker
    rollback = var.rollback_ecs
  }
  
  dynamic "placement_constraints" {
    for_each = var.enable_placement_constraints ? [1] : []
    content {
      expression = var.expression
      type       = var.type
    }
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.exposed_ecs_container_name
    container_port   = var.exposed_ecs_container_port
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
