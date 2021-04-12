locals {
  name_prefix            = "acme-example"
  default_region         = "eu-west-1"
  cloudtrail_bucket_name = "${local.name_prefix}-config-bucket"
  config_bucket_name     = "${local.name_prefix}-cloudtrail-bucket"

  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a
  # regex to parse it. You can then use the capture groups: e.g., local.parsed_path.region to get the current region.
  parsed_path = regex("(?P<root_path>.*?)/live/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
}

# In real code, this would generate the "aws" provider block instead
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "random" {}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.name_prefix}-${local.parsed_path.env}-${local.default_region}-tf-state"
    key            = "${local.parsed_path.env}/${local.parsed_path.region}/${local.parsed_path.module}/terraform.tfstate"
    region         = local.default_region
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}