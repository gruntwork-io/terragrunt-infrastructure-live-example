locals {
  parsed_path = regex(".*/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_terragrunt_dir()))
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  source = "../../../..//modules/account-baseline-app"

  common        = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  accounts      = jsondecode(file("${get_terragrunt_dir()}/../../../root/_global/account-baseline/accounts.json"))
}

inputs = {
  name_prefix               = local.env
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  allow_read_only_access_from_other_account_arns = [local.accounts["security"]]
  allow_full_access_from_other_account_arns      = [local.accounts["security"]]
}