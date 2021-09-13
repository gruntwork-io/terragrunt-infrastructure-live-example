locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  env         = local.common_vars.locals.env
  region      = local.common_vars.locals.region
  module      = local.common_vars.locals.module

  root_dir = dirname(find_in_parent_folders())
  # source_base_url = "github.com/<org>/modules.git//vpc"
  source_base_url = "${local.root_dir}/../modules/vpc"
}

inputs = {
  aws_region = local.region
  name       = "vpc-${local.env}"
}
