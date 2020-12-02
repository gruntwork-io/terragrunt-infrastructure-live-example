variable "name" {
  type = string
}

variable "ami" {
  type = string
}

variable "instances" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "mysql_endpoint" {
  type = string
}

resource "null_resource" "mock" {
  triggers = {
    name = var.name
    ami = var.ami
    instances = var.instances
    instance_type = var.instance_type
    vpc_id = var.vpc_id
    subnet_ids = join(",", var.subnet_ids)
    aws_region = var.aws_region
    mysql_endpoint = var.mysql_endpoint
  }
}

output "public_ip" {
  value = "1.2.3.4"
}

output "port" {
  value = 8080
}