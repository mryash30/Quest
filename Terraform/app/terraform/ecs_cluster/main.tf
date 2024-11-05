module "cluster" {
  source       = "../../../shared/module/ecs/cluster"
  cluster_name = "${local.cluster_name_prefix}-cluster"
  tags = merge(local.common_tags, {
    "Name" = local.service_name_prefix
  })
  enable_container_insights = local.workspace["cluster"]["enable_container_insights"]
}
