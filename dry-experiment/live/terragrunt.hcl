# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load common variables
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  # Extract the variables we need for easy access
  account_name = local.common_vars.locals.env
  account_id   = local.common_vars.locals.account_id
  aws_region   = local.common_vars.locals.region
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "null" {}

# AWS Provider data shown for demonstration purposes
#provider "aws" {
#  region = "${local.aws_region}"
#
#  # Only these AWS Account IDs may be operated on by this template
#  allowed_account_ids = ["${local.account_id}"]
#}
EOF
}

# The following is shown for demonstration purposes
#
# Configure Terragrunt to automatically store tfstate files in an S3 bucket
#remote_state {
#  backend = "s3"
#  config = {
#    encrypt        = true
#    bucket         = "${get_env("TG_BUCKET_PREFIX", "")}terragrunt-example-terraform-state-${local.account_name}-${local.aws_region}"
#    key            = "${path_relative_to_include()}/terraform.tfstate"
#    region         = local.aws_region
#    dynamodb_table = "terraform-locks"
#  }
#  generate = {
#    path      = "backend.tf"
#    if_exists = "overwrite_terragrunt"
#  }
#}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = local.common_vars.locals.common_input
