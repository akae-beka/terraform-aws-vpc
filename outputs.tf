output "private_subnets" {
  description = "Private subnets"
  value       = module.aws_vpc.this_private_subnet
}

output "public_subnets" {
  description = "Public subnets"
  value       = module.aws_vpc.this_public_subnet
}