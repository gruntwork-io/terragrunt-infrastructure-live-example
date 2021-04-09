variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "num_nat_gateways" {
  type = number
}

variable "num_availability_zones" {
  type    = number
  default = 3
}