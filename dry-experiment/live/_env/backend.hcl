locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a regex to parse it.
  parsed_path = regex("(?P<repo_root>.*?/live)/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  repo_root   = local.parsed_path.repo_root
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
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

dependency "mysql" {
  config_path = "${get_original_terragrunt_dir()}/../mysql"
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
