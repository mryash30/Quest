data "template_file" "policy_ops_asg" {
  template = file("${path.module}/iam_policy.tpl")
}

resource "aws_iam_policy" "asg_policy" {
  name        = "${local.service_name_prefix}-asg-policy"
  path        = "/"
  description = "${local.service_name_prefix}-asg-policy"
  policy      = data.template_file.policy_ops_asg.rendered
  tags        = merge(local.common_tags, tomap({ "Name" : "${local.service_name_prefix}-asg-policy" }))
}

module "ec2_asg_role" {
  source           = "../../../shared/module/iam/role"
  role_name        = "${local.service_name_prefix}-asg"
  role_description = "asg EC2 role access"
  assume_role      = "ec2.amazonaws.com"
  common_tags      = local.common_tags
}

resource "aws_iam_role_policy_attachment" "asg_ssm_managed_instance_core_policy" {
  role       = module.ec2_asg_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "asg_cloudwatch_agent_server_policy" {
  role       = module.ec2_asg_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "asg_cloudwatch_agent_admin_policy" {
  role       = module.ec2_asg_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

resource "aws_iam_role_policy_attachment" "asg_ec2_container_service_policy" {
  role       = module.ec2_asg_role.role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "asg_policy_attachment1" {
  role       = module.ec2_asg_role.role_name
  policy_arn = aws_iam_policy.asg_policy.arn
}
