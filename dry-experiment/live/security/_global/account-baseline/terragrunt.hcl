include "root" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}

terraform {
  source = "../../../..//modules/account-baseline-security"
}

inputs = {
  name_prefix               = "security"
  cloudtrail_bucket_name    = include.root.locals.cloudtrail_bucket_name
  config_bucket_name        = include.root.locals.config_bucket_name

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
