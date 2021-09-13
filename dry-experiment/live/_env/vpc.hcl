locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  source_base_url = "../../../..//modules/vpc"
}

# The default input variables that apply across all environments. Modules that include this one can add additional
# variables or override these ones in their own inputs blocks.
inputs = {
  vpc_name         = "vpc-${local.common.locals.parsed_path.env}"
  num_nat_gateways = 1
}
