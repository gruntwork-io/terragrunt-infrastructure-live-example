locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a regex to parse it.
  parsed_path = regex("(?P<repo_root>.*?/live)/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  repo_root   = local.parsed_path.repo_root
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module

  source = "../../../..//modules/account-baseline-app"

  common        = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  accounts      = jsondecode(file("${local.repo_root}/root/_global/account-baseline/accounts.json"))
}

inputs = {
  name_prefix               = local.env
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  allow_read_only_access_from_other_account_arns = [local.accounts["security"]]
  allow_full_access_from_other_account_arns      = [local.accounts["security"]]
}