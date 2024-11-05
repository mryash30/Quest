resource "aws_lb" "alb" {
  name                       = var.name
  internal                   = var.is_private_load_balancer
  security_groups            = var.security_groups
  load_balancer_type         = var.load_balancer_type
  subnets                    = var.subnets
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  drop_invalid_header_fields = var.drop_invalid_header_fields
  preserve_host_header       = var.preserve_host_header
  access_logs {
    bucket  = var.log_bucket_name
    prefix  = var.log_bucket_prefix
    enabled = var.log_enable
  }
  tags = var.tags
}
