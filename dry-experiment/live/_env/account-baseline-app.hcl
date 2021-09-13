locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  source_base_url = "../../../..//modules/account-baseline-app"
}

# The default input variables that apply across all environments. Modules that include this one can add additional
# variables or override these ones in their own inputs blocks.
inputs = {
  name_prefix               = local.common.locals.parsed_path.env
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  allow_read_only_access_from_other_account_arns = [local.common.locals.accounts["security"]]
  allow_full_access_from_other_account_arns      = [local.common.locals.accounts["security"]]
}
