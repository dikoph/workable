output "vpc_id" {
  value = module.vpc_module.vpc_id
}

output "public_subnets" {
  value = module.vpc_module.public_subnets
}

output "private_subnets" {
  value = module.vpc_module.private_subnets
}
