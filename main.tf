# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY AWS VPC WITH NETWORK RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "aws_vpc" {
  source = "./modules/vpc"

  create_vpc       = var.create
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
}