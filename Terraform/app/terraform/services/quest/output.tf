output "task_def_arn" {
  value = module.cluster_service.task_def_arn
}
output "target_group_arn" {
  value = module.cluster_service.target_group_arn
}
output "ecs_service_name" {
  value = module.cluster_service.ecs_service_name
}
