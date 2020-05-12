output "vpc_id" {
  description = "The ID of the main VPC."
  value       = module.aws_vpc.this_main_vpc_id
}

output "private_subnets_ids" {
  description = "The IDs of the private subnets."
  value       = module.aws_vpc.this_private_subnet_ids
}

output "public_subnets_ids" {
  description = "The IDs of the public subnets."
  value       = module.aws_vpc.this_public_subnet_ids
}