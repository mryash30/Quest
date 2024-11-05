locals {
  config                 = yamldecode(file("${path.module}/config.yml"))
  common                 = local.config["common"]
  env_space              = yamldecode(file("${path.module}/config_${terraform.workspace}.yml"))
  workspace              = local.env_space["workspace"]
  workspace_common       = local.workspace["common"]
  workspace_aws          = local.workspace["aws"]
  project_name_prefix = "${local.common["project_name_prefix"]}-${local.workspace_common["environment"]}-${local.workspace_common["region_code"]}-vpc"
  common_tags = merge(
    local.common["tags"],
    tomap({
      "workspace"   = terraform.workspace
    })
  )

  role_enable    = local.workspace["aws"]["role"] == "" ? [] : ["arn:aws:iam::${local.workspace["aws"]["account_id"]}:role/${local.workspace["aws"]["role"]}"]
  profile_enable = local.workspace_aws["profile"] == "" ? null : local.workspace_aws["profile"]
}

provider "aws" {
  region  = local.workspace_aws["region"]
  profile = local.profile_enable
  dynamic "assume_role" {
    for_each = local.role_enable
    content {
      role_arn = assume_role.value
    }
  }
}

data "aws_caller_identity" "current" {}
