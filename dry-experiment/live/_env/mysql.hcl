locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))

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
terraform {
  source = "${local.parsed_path.root_path}/modules//mysql"
}

dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../vpc"
}

inputs = merge(
  {
    name       = "mysql-${local.parsed_path.env}"
    vpc_id     = dependency.vpc.outputs.vpc_id
    subnet_ids = dependency.vpc.outputs.private_persistence_subnet_ids
  },
  local.vars[local.parsed_path.env]
)
