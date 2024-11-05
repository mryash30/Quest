module "cluster_service" {
  source = "../../../../shared/module/ecs/service-new"

  name                 = "${local.service_name_prefix}-${local.workspace["service"]["name"]}-service"
  td_name              = "${local.service_name_prefix}-${local.workspace["service"]["name"]}-td"
  vpc_id               = data.terraform_remote_state.netwoking.outputs.vpc_id
  deregistration_delay = local.workspace["service"]["target_group_deregistration_delay"]
  slow_start           = local.workspace["service"]["target_group_slow_start"]
  port                 = local.workspace["service"]["target_group_port"]
  protocol             = local.workspace["service"]["target_group_protocol"]
  target_type          = local.workspace["service"]["target_group_type"]
  health_check = {
    check_protocol      = "HTTP"
    check_port          = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 4
    timeout             = 5
    interval            = 30
    http_status         = "200"
  }
  health_check_path = local.workspace["service"]["target_group_health_check_path"]

  enable_execute_command             = local.workspace["service"]["enable_execute_command"]
  enable_circuit_breaker             = local.workspace["service"]["enable_circuit_breaker"]
  rollback_ecs                       = local.workspace["service"]["rollback_ecs"]
  container_definitions              = data.template_file.temp_task_def.rendered
  ecs_task_role_arn                  = module.ecs_task_role.role_arn
  ecs_execution_role_arn             = module.ecs_execution_role.role_arn
  host_log                           = local.workspace["service"]["td_host_log"]
  host_log_path                      = "/opt/logs/${local.workspace["service"]["name"]}"
  host_log_1                         = local.workspace["service"]["nginx_td_host_log"]
  host_log_path_1                    = "/opt/logs/${local.workspace["service"]["name"]}-nginx"
  ecs_task_desired_count             = local.workspace["service"]["ecs_task_desired_count"]
  deployment_maximum_percent         = local.workspace["service"]["deployment_maximum_percent"]
  deployment_minimum_healthy_percent = local.workspace["service"]["deployment_minimum_healthy_percent"]
  ecs_cluster_id                     = data.terraform_remote_state.ecs_cluster.outputs.cluster_arn
  ecs_service_role_arn               = "arn:aws:iam::654654531100:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  exposed_ecs_container_name         = "${local.workspace["service"]["name"]}-${local.workspace_common["environment"]}"
  exposed_ecs_container_port         = local.workspace["service"]["exposed_ecs_container_port"]
  health_check_grace_period_seconds  = local.workspace["service"]["health_check_grace_period_seconds"]
  enable_placement_constraints       = local.workspace["service"]["enable_placement_constraints"]
  expression                         = local.workspace["service"]["placement_constraints"][0]["expression"]
  type                               = local.workspace["service"]["placement_constraints"][0]["type"]
  tags = merge(local.common_tags, {
    "Name" = "${local.service_name_prefix}-${local.workspace["service"]["name"]}"
  })
}
