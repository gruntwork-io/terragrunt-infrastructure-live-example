terraform {
  source = "../../../..//modules/account-baseline-root"
}

include {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  name_prefix = "root"

  child_accounts = {
    logs = {
      email           = "example+logs@acme.com"
      is_logs_account = true
    }
    security = {
      email           = "example+security@acme.com"
      is_logs_account = false
    }
    dev = {
      email           = "example+dev@acme.com"
      is_logs_account = false
    }
    stage = {
      email           = "example+stage@acme.com"
      is_logs_account = false
    }
    prod = {
      email           = "example+prod@acme.com"
      is_logs_account = false
    }
  }

  cloudtrail_bucket_name = local.common.locals.cloudtrail_bucket_name
  config_bucket_name     = local.common.locals.config_bucket_name

  accounts_json_path = "${get_terragrunt_dir()}/accounts.json"
}