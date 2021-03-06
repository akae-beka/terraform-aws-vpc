# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "create_vpc" {
  description = "Controls if the VPC resources should be created."
  type        = bool
}

variable "az" {
  description = "Number of availability zones"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the search value in the `/etc/resolv.conf file`."
  type        = string
  default     = "eu-central-1.compute.internal"
}

variable "domain_name_servers" {
  description = "List of name servers to configure in `/etc/resolv.conf.`"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  type        = bool
  default     = true
}

variable "rtb_cidr_block" {
  description = "The CIDR block of the route."
  type        = string
  default     = "0.0.0.0/0"
}
