output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "vpc_id" {
  value = module.vpc_main.vpc_id
}

output "vpc_cidr" {
  value = module.vpc_main.vpc_cidr
}

output "subnet_details_id" {
  value = module.vpc_main.subnet_details_id
}

output "subnet_details_cidr" {
  value = module.vpc_main.subnet_details_cidr
}

output "internet_gateway_id" {
  value = module.vpc_main.internet_gateway_id
}

output "route_table_id" {
  value = module.vpc_main.route_table_id
}

output "database_subnet" {
  value = module.vpc_main.subnet_ids.database[*]
}
output "public_subnet" {
  value = module.vpc_main.subnet_ids.public[*]
}

output "private_subnet" {
  value = module.vpc_main.subnet_ids.private[*]
}


output "subnet_cidr" {
  value = module.vpc_main.subnet_cidr
}

