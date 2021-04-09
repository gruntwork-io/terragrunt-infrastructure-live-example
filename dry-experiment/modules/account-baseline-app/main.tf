resource "random_string" "mock_account_baseline" {
  keepers = {
    name_prefix                                    = var.name_prefix
    config_s3_bucket_name                          = var.config_bucket_name
    cloudtrail_s3_bucket_name                      = var.cloudtrail_bucket_name
    allow_read_only_access_from_other_account_arns = join(",", var.allow_read_only_access_from_other_account_arns)
    allow_full_access_from_other_account_arns      = join(",", var.allow_full_access_from_other_account_arns)
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}
