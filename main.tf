# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY AWS VPC WITH NETWORK RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "aws_vpc" {
  source = "./modules/vpc"

  create_vpc                       = var.create
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
}