# terraform-aws-vpc

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module to create Amazon VPC

## Usage

```
provider "aws" {
  region = "eu-central-1"
}

module "aws_vpc" {
  source = "git::github.com/akae-beka/terraform-aws-vpc?ref=developer-0.13"

  create     = true
  cidr_block = "10.0.0.0/16"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.4 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_block | The CIDR block for the VPC. | `string` | n/a | yes |
| create | Boolean that controls whether or not to create all vpc resources. | `bool` | n/a | yes |

## License

This code is released under the Apache 2.0 License. [LICENSE](https://github.com/akae-beka/terraform-aws-vpc/blob/master/LICENSE)