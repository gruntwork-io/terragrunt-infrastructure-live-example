locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a regex to parse it.
  parsed_path = regex("(?P<repo_root>.*?/live)/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  repo_root   = local.parsed_path.repo_root
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  source = "../../../..//modules/vpc"

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

inputs = merge(
  {
    vpc_name         = "vpc-${local.env}"
    num_nat_gateways = 1
  },
  local.vars[local.env]
)