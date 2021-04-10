locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))

  vars = {
    dev = {
      docker_image_version = "v4"
      replicas             = 1
    }
    stage = {
      docker_image_version = "v3"
      replicas             = 1
    }
    prod = {
      docker_image_version = "v3"
      replicas             = 3
    }
  }
}

terraform {
  source = "${local.parsed_path.root_path}/modules//ecs-fargate-service"
}

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

dependency "mysql" {
  config_path = "${get_original_terragrunt_dir()}/../mysql"
}

inputs = merge(
  {
    name                 = "backend-${local.parsed_path.env}"
    docker_image         = "gruntwork-io/backend-app"
    vpc_id               = dependency.vpc.outputs.vpc_id
    subnet_ids           = dependency.vpc.outputs.private_persistence_subnet_ids
    env_vars             = {
      DB_ENDPOINT = dependency.mysql.outputs.primary_endpoint
      DB_PORT     = dependency.mysql.outputs.port
    }
  },
  local.vars[local.parsed_path.env]
)
