locals {
  # abspath(".") should be something like <PATH>/live/<ENV>/<REGION>/<MODULE>
  parsed_path = regex(".*/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module
  account_id  = local.account_ids[local.env]

  account_ids = {
    dev   = "000000000000"
    stage = "000000000000"
    prod  = "000000000000"
  }

  common_input = {
    aws_account_id = local.account_id
    aws_region     = local.region
  }
}
