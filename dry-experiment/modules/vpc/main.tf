resource "random_string" "mock_vpc" {
  keepers = {
    vpc_name         = var.vpc_name
    cidr_block       = var.cidr_block
    num_nat_gateways = var.num_nat_gateways
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}

resource "random_string" "mock_subnets" {
  count = var.num_availability_zones * local.num_subnet_tiers

  keepers = {
    vpc_name         = var.vpc_name
    cidr_block       = var.cidr_block
    num_nat_gateways = var.num_nat_gateways
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}

locals {
  num_subnet_tiers = 3
}