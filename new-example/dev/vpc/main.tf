variable "name" {
  type = string
}

output "vpc_id" {
  value = "ID: ${var.name}"
}
