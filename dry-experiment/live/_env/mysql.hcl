locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env         = local.common_vars.locals.env
  region      = local.common_vars.locals.region
  module      = local.common_vars.locals.module

  root_dir = dirname(find_in_parent_folders())
  # source_base_url = "github.com/<org>/modules.git//mysql"
  source_base_url = "${local.root_dir}/../modules/mysql"
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
}

inputs = {
  aws_region = local.region
  name       = "mysql-${local.env}"
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.subnet_ids
}
