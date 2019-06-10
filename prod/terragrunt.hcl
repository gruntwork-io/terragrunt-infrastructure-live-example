# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "terragrunt-example-terraform-state-prod"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = {
  aws_region                   = "us-east-1"
  aws_profile                  = "prod"
  tfstate_global_bucket        = "terragrunt-example-terraform-state-prod"
  tfstate_global_bucket_region = "us-east-1"
}
