terraform {
  source = "../../../..//modules/account-baseline-security"
}

include {
  path = find_in_parent_folders()
}

locals {
  common   = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

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