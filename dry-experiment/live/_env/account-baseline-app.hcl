locals {
  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  accounts    = jsondecode(file("${local.parsed_path.root_path}/live/root/_global/account-baseline/accounts.json"))
}

terraform {
  source = "${local.parsed_path.root_path}/modules//account-baseline-app"
}

generate     = local.common.generate
remote_state = local.common.remote_state

inputs = {
  name_prefix               = local.parsed_path.env
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  allow_read_only_access_from_other_account_arns = [local.accounts["security"]]
  allow_full_access_from_other_account_arns      = [local.accounts["security"]]
}