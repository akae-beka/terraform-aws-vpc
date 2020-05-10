# terraform-aws-vpc

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

Terraform module to create Amazon VPC


### Usage

```
provider "aws" {
  region = "eu-central-1"
}

module "aws_vpc" {
  source = "git::github.com/akae-beka/terraform-aws-vpc"

  create     = true
  cidr_block = "10.0.0.0/16"
}
```