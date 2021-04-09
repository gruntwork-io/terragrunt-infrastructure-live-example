locals {
  parsed_path = regex(".*/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_terragrunt_dir()))
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
  config_path = "${get_terragrunt_dir()}/../vpc"
}

inputs = merge(
  {
    name       = "mysql-${local.env}"
    vpc_id     = dependency.vpc.outputs.vpc_id
    subnet_ids = dependency.vpc.outputs.private_persistence_subnet_ids
  },
  local.vars[local.env]
)
