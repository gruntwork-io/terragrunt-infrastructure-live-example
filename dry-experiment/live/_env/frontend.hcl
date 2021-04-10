locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))

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

generate     = local.common.locals.generate
remote_state = local.common.locals.remote_state

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

dependency "backend" {
  config_path = "${get_original_terragrunt_dir()}/../backend"
}

inputs = merge(
  {
    name                 = "frontend-${local.parsed_path.env}"
    docker_image         = "gruntwork-io/frontend-app"
    vpc_id               = dependency.vpc.outputs.vpc_id
    subnet_ids           = dependency.vpc.outputs.private_persistence_subnet_ids
    env_vars             = {
      BACKEND_ENDPOINT = dependency.backend.outputs.service_endpoint
    }
  },
  local.vars[local.parsed_path.env]
)
