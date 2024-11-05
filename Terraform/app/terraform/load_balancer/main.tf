module "load_balancer" {
  source                     = "../../../shared/module/ec2/load-balancer"
  count                      = length(local.workspace["ec2"]["load_balancer"])
  name                       = join("-",[local.service_name_prefix, local.workspace["ec2"]["load_balancer"][count.index].name])
  tags                       = merge(local.common_tags, tomap({ "Name" : local.service_name_prefix }))
  enable_deletion_protection = local.workspace["ec2"]["load_balancer"][count.index].enable_deletion_protection
  is_private_load_balancer   = local.workspace["ec2"]["load_balancer"][count.index].is_private_load_balancer
  idle_timeout               = local.workspace["ec2"]["load_balancer"][count.index].idle_timeout
  drop_invalid_header_fields = local.workspace["ec2"]["load_balancer"][count.index].drop_invalid_header_fields 
  load_balancer_type         = local.workspace["ec2"]["load_balancer"][count.index].load_balancer_type
  log_enable                 = local.workspace["ec2"]["load_balancer"][count.index].log_enable
  log_bucket_name            = local.workspace["ec2"]["load_balancer"][count.index].log_bucket_name
  log_bucket_prefix          = local.workspace["ec2"]["load_balancer"][count.index].log_bucket_prefix
  security_groups            = [aws_security_group.public_alb_security_group.id]
  subnets                    = ["subnet-0ed9fba7061cef1d2","subnet-0acad9154295e3000"]

  }

module "lb_http_listener" {
  count                        = length(local.workspace["ec2"]["load_balancer"])
  is_private_load_balancer     = local.workspace["ec2"]["load_balancer"][count.index].is_private_load_balancer
  source                       = "../../../shared/module/ec2/load-balancer/listener/http"
  listener_action_type         = local.workspace["ec2"]["load_balancer"][count.index].listener_action_type
  listener_port                = local.workspace["ec2"]["load_balancer"][count.index].http_listener_port
  listener_protocol            = local.workspace["ec2"]["load_balancer"][count.index].http_listener_protocol
  load_balancer_arn            = module.load_balancer[count.index].alb_arn
}
