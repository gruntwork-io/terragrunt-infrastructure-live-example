locals {
  # Automatically load common variables shared across all accounts
  common_vars    = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  default_region = local.common_vars.locals.default_region

  # abspath(get_original_terragrunt_dir()) should return something like <PATH>/live/<ENV>/<REGION>/<MODULE>. We use a regex to parse it.
  parsed_path = regex("(?P<repo_root>.*?/live)/(?P<env>.*?)/(?P<region>.*?)/(?P<module>.*)", abspath(get_original_terragrunt_dir()))
  repo_root   = local.parsed_path.repo_root
  env         = local.parsed_path.env
  region      = local.parsed_path.region
  module      = local.parsed_path.module
}

# In real code, this would generate the "aws" provider block instead
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "random" {}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.common_vars.locals.name_prefix}-${local.env}-${local.default_region}-tf-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.default_region
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}