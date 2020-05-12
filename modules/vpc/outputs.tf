output "this_main_vpc" {
  description = "The ID of the main VPC."
  value       = element(aws_vpc.main.*.id, 0)
}

output "this_private_subnet" {
  description = "The IDs of the private subnets."
  value       = concat(aws_subnet.private.*.id)
}

output "this_public_subnet" {
  description = "The IDs of the public subnets."
  value       = concat(aws_subnet.public.*.id)
}