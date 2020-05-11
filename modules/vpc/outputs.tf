output "this_private_subnet" {
  description = "Private subnets"
  value       = concat(aws_subnet.private.*.id)
}

output "this_public_subnet" {
  description = "Public subnets"
  value       = concat(aws_subnet.public.*.id)
}