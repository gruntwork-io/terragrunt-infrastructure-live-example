terraform {
  source = "../../../..//modules/account-baseline-app"
}

generate     = local.common.locals.generate
remote_state = local.common.locals.remote_state

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  accounts = jsondecode(file("${get_terragrunt_dir()}/../../../root/_global/account-baseline/accounts.json"))
}

inputs = {
  name_prefix               = "logs"
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  allow_read_only_access_from_other_account_arns = [local.accounts["security"]]
  allow_full_access_from_other_account_arns      = [local.accounts["security"]]
}