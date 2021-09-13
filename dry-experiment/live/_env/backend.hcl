locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  source_base_url = "../../../..//modules/ecs-fargate-service"
}

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

dependency "mysql" {
  config_path = "${get_original_terragrunt_dir()}/../mysql"
}

# The default input variables that apply across all environments. Modules that include this one can add additional
# variables or override these ones in their own inputs blocks.
inputs = {
  name                 = "backend-${local.common.locals.parsed_path.env}"
  docker_image         = "gruntwork-io/backend-app"
  vpc_id               = dependency.vpc.outputs.vpc_id
  subnet_ids           = dependency.vpc.outputs.private_persistence_subnet_ids
  env_vars             = {
    DB_ENDPOINT = dependency.mysql.outputs.primary_endpoint
    DB_PORT     = dependency.mysql.outputs.port
  }
}
