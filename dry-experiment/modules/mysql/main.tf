variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

resource "null_resource" "mock" {
  triggers = {
    name = var.name
    vpc_id = var.vpc_id
    subnet_ids = join(",", var.subnet_ids)
    aws_region = var.aws_region
    instance_type = var.instance_type
  }
}

output "endpoint" {
  value = "mock-db-endpoint.us-east-1.amazonaws.com"
}

output "port" {
  value = 3306
}