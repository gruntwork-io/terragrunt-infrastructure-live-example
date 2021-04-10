terraform {
  source = "../../../..//modules/account-baseline-security"
}

locals {
  common   = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

generate     = local.common.locals.generate
remote_state = local.common.locals.remote_state

inputs = {
  name_prefix               = "security"
  cloudtrail_bucket_name    = local.common.locals.cloudtrail_bucket_name
  config_bucket_name        = local.common.locals.config_bucket_name

  iam_users = {
    alice = {
      groups  = ["full-admin"]
      pgp_key = "keybase:alice"
    }
    bob = {
      groups  = ["read-only"]
      pgp_key = "keybase:bob"
    }
  }
}