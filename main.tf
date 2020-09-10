# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13"
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY AWS VPC WITH NETWORK RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "aws_vpc" {
  source = "./modules/vpc"

  create_vpc = var.create
  cidr_block = var.cidr_block
}