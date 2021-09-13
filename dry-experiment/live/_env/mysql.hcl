locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  source_base_url = "../../../..//modules/mysql"
}

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

# The default input variables that apply across all environments. Modules that include this one can add additional
# variables or override these ones in their own inputs blocks.
inputs = {
  name       = "mysql-${local.common.locals.parsed_path.env}"
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_persistence_subnet_ids
}
