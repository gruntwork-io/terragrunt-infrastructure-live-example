resource "random_string" "mock_ecs_fargate_service" {
  keepers = {
    name                 = var.name
    docker_image         = var.docker_image
    docker_image_version = var.docker_image_version
    replicas             = var.replicas
    env_vars             = jsonencode(var.env_vars)
    vpc_id               = var.vpc_id
    subnet_ids           = join(",", var.subnet_ids)
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}
