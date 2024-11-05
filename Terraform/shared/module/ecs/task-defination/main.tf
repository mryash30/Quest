resource "aws_ecs_task_definition" "task" {
  family       = var.task_def_name
  network_mode = var.network_mode

  requires_compatibilities = [
  var.requires_compatibilities]
  container_definitions = var.container_definitions
  task_role_arn         = var.ecs_task_role_arn
  execution_role_arn = var.ecs_execution_role_role
  tags                  = var.tags
  volume {
    name      = var.host_log
    host_path = var.host_log_path
  }
  volume {
    name      = var.host_log_1
    host_path = var.host_log_path_1
  }
}
