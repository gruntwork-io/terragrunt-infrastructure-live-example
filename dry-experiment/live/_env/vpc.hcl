locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  vars = {
    dev = {
      cidr_block = "10.0.0.0/16"
    }
    stage = {
      cidr_block = "10.10.0.0/16"
    }
    prod = {
      cidr_block       = "10.20.0.0/16"
      num_nat_gateways = 3
    }
  }
}

terraform {
  source = "${local.parsed_path.root_path}/modules//vpc"
}

generate     = local.common.locals.generate
remote_state = local.common.locals.remote_state

inputs = merge(
  {
    vpc_name         = "vpc-${local.parsed_path.env}"
    num_nat_gateways = 1
  },
  local.vars[local.parsed_path.env]
)