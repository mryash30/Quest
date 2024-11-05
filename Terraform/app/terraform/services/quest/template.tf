data "template_file" "temp_task_def" {
  template = file("${path.module}/task-defination.tpl")

  vars = {
    container_name = "${local.workspace["service"]["name"]}-${local.workspace_common["environment"]}"
    container_port = local.workspace["service"]["exposed_ecs_container_port"]

    image_name = "654654531100.dkr.ecr.us-east-1.amazonaws.com/quest:latest"
    mount_volume             = local.workspace["service"]["td_host_log"]
    mount_path               = local.workspace["service"]["td_host_log_mount_path"]
    container_cpu            = local.workspace["service"]["exposed_ecs_container_cpu"]
    container_memory         = local.workspace["service"]["exposed_ecs_container_memory"]
    container_nginx_log_path = local.workspace["service"]["nginx_td_host_log_mount_path"]
    host_nginx_log           = local.workspace["service"]["nginx_td_host_log"]
    env                      = terraform.workspace
    project_name             = local.common["project_name_prefix"]
    application_name         = local.workspace["service"]["name"]
    region                   = local.workspace["aws"]["region"]
  }
}
