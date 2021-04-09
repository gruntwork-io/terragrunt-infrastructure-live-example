locals {
  parsed_path = regex(".*/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_terragrunt_dir()))
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  source = "../../../..//modules/ecs-fargate-service"

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

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
}

dependency "mysql" {
  config_path = "${get_terragrunt_dir()}/../mysql"
}

inputs = merge(
  {
    name                 = "backend-${local.env}"
    docker_image         = "gruntwork-io/backend-app"
    vpc_id               = dependency.vpc.outputs.vpc_id
    subnet_ids           = dependency.vpc.outputs.private_persistence_subnet_ids
    env_vars             = {
      DB_ENDPOINT = dependency.mysql.outputs.primary_endpoint
      DB_PORT     = dependency.mysql.outputs.port
    }
  },
  local.vars[local.env]
)
