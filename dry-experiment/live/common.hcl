locals {
  name_prefix            = "acme-example"
  default_region         = "eu-west-1"
  cloudtrail_bucket_name = "${local.name_prefix}-config-bucket"
  config_bucket_name     = "${local.name_prefix}-cloudtrail-bucket"
}