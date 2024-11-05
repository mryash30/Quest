data "template_file" "launch_temp_user_data" {
  template = file("${path.module}/${local.workspace["asg"]["user_data_script"]}")
  vars = {
    environment      = terraform.workspace
    cluster_name     = "${local.common_name_prefix}-cluster"
    region           = local.workspace_aws["region"]
  }
}
