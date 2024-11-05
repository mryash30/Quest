resource "aws_security_group" "asg_security_group" {
  name        = "${local.service_name_prefix}-asg-sg"
  tags        = merge(local.common_tags, tomap({ "Name" : "${local.service_name_prefix}-asg-sg" }))
  description = "Application Autoscaling group"
  vpc_id      = data.terraform_remote_state.netwoking.outputs.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = ["sg-0f84033842322b2eb"]
    description = "Allow traffic from Private Load Balancer"
  }

    ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = flatten([data.terraform_remote_state.load_balancer.outputs.public_sg])
    description = "Allow traffic from Public Load Balancer"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic to Internet"
  }


}