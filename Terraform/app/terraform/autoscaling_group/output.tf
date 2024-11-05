output "aws_launch_template_id" {
  value = module.auto_scaling_group.aws_launch_template_id
}
output "auto_scaling_group_name" {
  value = module.auto_scaling_group.asg_name
}
output "auto_scaling_group_arn" {
  value = module.auto_scaling_group.asg_arn
}
output "latest_ecs_ami" {
  value = data.aws_ami.ecs_official_image.id
}
output "latest_ecs_ami_name" {
  value = data.aws_ami.ecs_official_image.name
}

