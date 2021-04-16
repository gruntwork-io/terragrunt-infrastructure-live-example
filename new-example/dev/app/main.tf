variable "vpc_id" {
  type = string
}

variable "db_domain" {
  type = string
}

output "app_domain" {
  value = "mydomain"
}
