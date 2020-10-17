# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.13"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE AWS VPC WITH NETWORK RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

locals {
  tags = {
    Description = "Managed by Terraform"
    Environment = terraform.workspace
  }
}

data "aws_availability_zones" "main" {}

resource "aws_vpc" "main" {
  count = var.create_vpc && var.cidr_block != null ? 1 : 0

  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    local.tags,
    {
      Name = "vpc-${terraform.workspace}-basic"
    }
  )
}

resource "aws_vpc_dhcp_options" "main" {
  count = var.create_vpc && var.domain_name == var.domain_name_servers != "" ? 1 : 0

  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers

  tags = merge(
    local.tags,
    {
      Name = "dhcp-${terraform.workspace}"
    }
  )
}

resource "aws_vpc_dhcp_options_association" "main" {
  count = var.create_vpc ? 1 : 0

  vpc_id          = aws_vpc.main[0].id
  dhcp_options_id = aws_vpc_dhcp_options.main[0].id
}

resource "aws_subnet" "private" {
  count = var.create_vpc ? length(var.az) : 0

  vpc_id            = aws_vpc.main[0].id
  cidr_block        = cidrsubnet(aws_vpc.main[0].cidr_block, 8, count.index)
  availability_zone = concat(data.aws_availability_zones.main.names, [""])[count.index]

  tags = merge(
    local.tags,
    {
      Name = "subnet${var.az[count.index]}-${terraform.workspace}-private"
    }
  )
}

resource "aws_subnet" "public" {
  count = var.create_vpc ? length(var.az) : 0

  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = cidrsubnet(aws_vpc.main[0].cidr_block, 8, length(var.az) + count.index)
  availability_zone       = concat(data.aws_availability_zones.main.names, [""])[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    local.tags,
    {
      Name = "subnet${var.az[count.index]}-${terraform.workspace}-public"
    }
  )
}

resource "aws_internet_gateway" "main" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  tags = merge(
    local.tags,
    {
      Name = "igw-${terraform.workspace}"
    }
  )
}

resource "aws_eip" "main" {
  count = var.create_vpc && length(aws_internet_gateway.main) > 0 ? length(aws_subnet.public) : 0

  vpc = true

  tags = merge(
    local.tags,
    {
      Name = "eip-${terraform.workspace}"
    }
  )
}

resource "aws_nat_gateway" "main" {
  count = var.create_vpc ? 3 : 0

  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = element(aws_eip.main.*.id, count.index)
}

resource "aws_route_table" "main" {
  count = var.create_vpc && length(aws_internet_gateway.main) > 0 ? length(aws_nat_gateway.main) : 0

  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block     = var.rtb_cidr_block
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(
    local.tags,
    {
      Name = "rtb-${terraform.workspace}"
    }
  )
}

resource "aws_route_table_association" "main" {
  count = var.create_vpc ? length(aws_route_table.main) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.main[count.index].id
}

resource "aws_route" "main" {
  count = var.create_vpc ? 1 : 0

  route_table_id         = aws_vpc.main[0].main_route_table_id
  gateway_id             = aws_internet_gateway.main[count.index].id
  destination_cidr_block = var.rtb_cidr_block
}