resource "aws_lb_listener_rule" "listener_rule" {
  for_each = {
    for idx, rule in var.listener_rule : idx => rule
  }

  listener_arn = var.listener_arn
  priority     = each.value.priority
  tags         = each.value.tags
  
  dynamic "action" {
    for_each = {
      for action, condition in each.value.action : action => condition if condition.type == "forward"
    }

    content {
      type  = "forward"
      target_group_arn = var.target_group_arn
    }
  }   
  dynamic "action" {
    for_each = {
      for action, condition in each.value.action : action => condition if condition.type == "fixed-response"
    }

    content {
      type  = "fixed-response"

      fixed_response {
        content_type = action.value.content_type
        message_body = try(action.value.message_body, null)
        status_code  = try(action.value.status_code, null)
      }
    }
  }
  dynamic "action" {
    for_each = {
      for action, condition in each.value.action : action => condition if condition.type == "redirect"
    }

    content {
      type  = "redirect"

      redirect {
        port        = action.value.port
        protocol    =  try(action.value.protocol, null)
        host        =  try(action.value.host, null)
        path        =  try(action.value.path, null)
        query       =  try(action.value.query, null)
        status_code = try(action.value.status_code, null) 
      }
    }
  }  

  dynamic "condition" {
    for_each = {
      for idx, condition in each.value.condition : idx => condition if condition.is_path_pattern == true
    }

    content {
      dynamic "path_pattern" {
        for_each = try([condition.value.path_pattern_values], [])

        content {
          values = condition.value.path_pattern_values
        }
      }
    }
  }

  dynamic "condition" {
    for_each = {
      for idx, condition in each.value.condition : idx => condition if condition.is_host_header == true
    }

    content {
      dynamic "host_header" {
        for_each = try([condition.value.host_header_values], [])

        content {
          values = condition.value.host_header_values
        }
      }
    }
  }
}