# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

tfstate_global_bucket        = "terragrunt-state-global-non-prod"
tfstate_global_bucket_region = "us-east-1"
aws_profile                  = "non-prod"
