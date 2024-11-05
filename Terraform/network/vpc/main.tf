module "vpc_main" {
  source              = "git::https://github.com/tothenew/terraform-aws-vpc.git"
  cidr_block          = local.workspace["vpc"]["cidr_block"]
  subnet              = local.workspace["vpc"]["subnet"]
  create_vpc_endpoint = local.workspace["vpc"]["create_vpc_endpoint"]
  name                = local.project_name_prefix
  common_tags         = local.common_tags
}

