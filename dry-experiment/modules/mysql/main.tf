resource "random_string" "mock_db" {
  keepers = {
    name          = var.name
    instance_type = var.instance_type
    vpc_id        = var.vpc_id
    subnet_ids    = join(",", var.subnet_ids)
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}