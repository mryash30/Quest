output "task_def_arn" {
  value = aws_ecs_task_definition.task.arn
}

output "task_def_family" {
  value = aws_ecs_task_definition.task.family
}

output "task_def_revision" {
  value = aws_ecs_task_definition.task.revision
}
