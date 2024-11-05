output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "target_group_arn_suffix" {
  value = aws_lb_target_group.target_group.arn_suffix
}

output "task_def_arn" {
  value = aws_ecs_task_definition.task.arn
}
output "task_def_family" {
  value = aws_ecs_task_definition.task.family
}
output "task_def_revision" {
  value = aws_ecs_task_definition.task.revision
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}
