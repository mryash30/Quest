output "aws_launch_template_id" {
  value = aws_launch_template.launch_template.id
}

output "asg_name" {
  value = aws_autoscaling_group.asg-spot.name
}

output "asg_arn" {
  value = aws_autoscaling_group.asg-spot.arn
}

output "asg_id" {
  value = aws_autoscaling_group.asg-spot.id
}
