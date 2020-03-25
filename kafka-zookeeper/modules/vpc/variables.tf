/*
 Variables for VPC
*/

variable "environment" {}

variable "dhcp_domain_name_servers" {
    default = []
}


variable "vpc_cidr" {
   description = "Sring - Vpc cidrs. Will be mapped in individual env files"

}

variable "public_sub_cidr" {
   description = "Cidr for public subnet"
   default = []

}

variable "private_sub_cidr" {
   description = "Cidr for private subnet"
   default = []
}

variable "azs" {
   description = "Value for AZs for private subnet. Deploying two subnets for private vpc only"
   default = []
}

variable "enable_dns_hostnames" {
   description = "String - Boolean indicating if we need pub ips"
   default = false
}

variable "vpc_name" {
   description = "String - Name of vpc"
}
