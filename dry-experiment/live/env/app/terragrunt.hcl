locals {
  # abspath(".") should be something like <PATH>/live/<ENV>/<REGION>/<MODULE>
  parsed_path = regex(".*/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath("."))
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  # Centrally manage what version of the VPC module is used in each environment. This makes it easier to promote
  # a version from dev -> stage -> prod.
  module_version = {
    dev   = "v1.2.4"
    stage = "v1.2.3"
    prod  = "v1.2.3"
  }  
}

terraform {
  # source = "github.com/<org>/modules.git//app?ref=${local.module_version[local.env]}"
  source = "../../../../modules/app"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "mysql" {
  config_path = "../mysql"
}

inputs = {
  aws_region     = local.region
  name           = "example-app-${local.env}"
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_ids     = dependency.vpc.outputs.subnet_ids
  mysql_endpoint = dependency.mysql.outputs.endpoint
}