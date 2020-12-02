variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "aws_region" {
  type = string
}

resource "null_resource" "mock" {
  triggers = {
    name = var.name
    cidr_block = var.cidr_block
    aws_region = var.aws_region
  }
}

output "name" {
  value = var.name
}

output "cidr_block" {
  value = var.cidr_block
}

output "vpc_id" {
  value = "vpc-abcd1234"
}

output "subnet_ids" {
  value = ["subnet-abcd1111", "subnet-abcd2222", "subnet-abcd3333"]
}