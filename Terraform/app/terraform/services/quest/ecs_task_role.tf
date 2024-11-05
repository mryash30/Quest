module "ecs_task_role" {
  source           = "../../../../shared/module/iam/role-without-profile"
  role_name        = "${local.service_name_prefix}-${local.workspace["service"]["name"]}-task"
  role_description = "ECS task role access"
  assume_role      = "ecs-tasks.amazonaws.com"
  common_tags      = local.common_tags
}


resource "aws_iam_role_policy_attachment" "task_policy1" {
  role       = module.ecs_task_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role_policy_attachment" "task_policy5" {
  role       = module.ecs_task_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}


module "ecs_execution_role" {
  source           = "../../../../shared/module/iam/role-without-profile"
  role_name        = "${local.service_name_prefix}-${local.workspace["service"]["name"]}-execution"
  role_description = "ECS task role access"
  assume_role      = "ecs-tasks.amazonaws.com"
  common_tags      = local.common_tags
}

resource "aws_iam_role_policy_attachment" "execution_policy1" {
  role       = module.ecs_execution_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role_policy_attachment" "execution_policy5" {
  role       = module.ecs_execution_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
