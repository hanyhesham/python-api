output "id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "private_subnets" {
  value = module.vpc.private_subnets
}