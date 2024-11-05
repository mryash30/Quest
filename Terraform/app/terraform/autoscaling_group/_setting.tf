locals {
  config           = yamldecode(file("${path.module}/config.yml"))
  common           = local.config["common"]
  env_space        = yamldecode(file("${path.module}/config_${terraform.workspace}.yml"))
  workspace        = local.env_space["workspace"]
  workspace_common = local.workspace["common"]
  workspace_aws    = local.workspace["aws"]
  project_name_prefix = "${local.common["project_name_prefix"]}-${local.workspace_common["environment"]}-${local.workspace_common["region_code"]}"
  common_name_prefix = "${local.common["project_name_prefix"]}-${terraform.workspace}-${local.workspace_common["region_code"]}"
  service_name_prefix = "${local.common["project_name_prefix"]}-${terraform.workspace}"
  account_name_prefix = "${local.workspace_common["environment"]}-${local.common["project_name_prefix"]}"

  common_tags = merge(
    local.common["tags"],
    local.workspace_common["tags"],
    tomap({
      "createdby"   = "terraform"
    })
  )

  account_id = local.workspace_aws["account_id"]

  asg_common_tags = [
    {
      key                 = "workload"
      value               = "infra"
      propagate_at_launch = true
    },
    {
      key                 = "environment"
      value               = local.workspace_common["environment"]
      propagate_at_launch = true
    },
    {
      key                 = "workspace"
      value               = terraform.workspace
      propagate_at_launch = true
    },
    {
      key                 = "createdby"
      value               = "terraform"
      propagate_at_launch = true
    }
  ]

  role_enable = local.workspace["aws"]["role"] == "" ? [] : ["arn:aws:iam::${local.workspace["aws"]["account_id"]}:role/${local.workspace["aws"]["role"]}"]
  profile_enable = local.workspace_aws["profile"] == "" ? null : local.workspace_aws["profile"]
}

provider "aws" {
  region = local.workspace_aws["region"]
  profile = local.profile_enable
  dynamic "assume_role" {
    for_each = local.role_enable
    content {
      role_arn = assume_role.value
    }
  }
}

data "aws_caller_identity" "current" {}