# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"

    config {
      encrypt        = true
      bucket         = "terragrunt-example-non-prod-terraform-state"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terraform-locks"
    }
  }

  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "-var-file" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}",
      ]
    }
  }
}
