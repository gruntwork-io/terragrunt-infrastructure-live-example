locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a regex to parse it.
  parsed_path = regex("(?P<repo_root>.*?/live)/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  repo_root   = local.parsed_path.repo_root
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  source = "../../../..//modules/mysql"

  vars = {
    dev = {
      instance_type = "db.t3.micro"
    }
    stage = {
      instance_type = "db.t3.medium"
    }
    prod = {
      instance_type = "db.r4.large"
    }
  }
}

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

inputs = merge(
  {
    name       = "mysql-${local.env}"
    vpc_id     = dependency.vpc.outputs.vpc_id
    subnet_ids = dependency.vpc.outputs.private_persistence_subnet_ids
  },
  local.vars[local.env]
)
