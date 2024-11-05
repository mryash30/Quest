resource "aws_security_group" "public_alb_security_group" {
  name        = "${local.service_name_prefix}-public-alb-sg"
  tags        = merge(local.common_tags, tomap({ "Name" : "${local.service_name_prefix}-public-alb-sg" }))
  description = "Allow HTTP and HTTPS request from internet"
  vpc_id      = "vpc-0e28ca35ac350774b"
  

  dynamic "ingress" {
    for_each = local.workspace["security_group"]["public_sg"]["inbound"]
    iterator = each
    content {
      description     = each.value["description"]
      from_port       = each.value["from_port"]
      to_port         = each.value["to_port"]
      protocol        = each.value["protocol"]
      self            = each.value["self"]
      cidr_blocks     = contains(keys(each.value), "cidr_blocks") ? each.value["cidr_blocks"] : []
      security_groups = contains(keys(each.value), "security_groups") ? each.value["security_groups"] : []
      prefix_list_ids = contains(keys(each.value), "prefix_list_ids") ? each.value["prefix_list_ids"] : []
      ipv6_cidr_blocks = contains(keys(each.value), "ipv6_cidr_blocks") ? each.value["ipv6_cidr_blocks"] : []
    }
  }

  dynamic "egress" {
    for_each = local.workspace["security_group"]["public_sg"]["outbound"]
    iterator = each
    content {
      description     = each.value["description"]
      from_port       = each.value["from_port"]
      to_port         = each.value["to_port"]
      protocol        = each.value["protocol"]
      cidr_blocks     = contains(keys(each.value), "cidr_blocks") ? each.value["cidr_blocks"] : []
      security_groups = contains(keys(each.value), "security_groups") ? each.value["security_groups"] : []
      prefix_list_ids = contains(keys(each.value), "prefix_list_ids") ? each.value["prefix_list_ids"] : []
    }
  }

 }