resource "random_string" "mock_account_baseline" {
  keepers = {
    name_prefix               = var.name_prefix
    config_s3_bucket_name     = var.config_bucket_name
    cloudtrail_s3_bucket_name = var.cloudtrail_bucket_name
    iam_users                 = join(",", keys(var.iam_users))
  }

  length  = 8
  special = false
  lower   = true
  number  = true
  upper   = false
}
