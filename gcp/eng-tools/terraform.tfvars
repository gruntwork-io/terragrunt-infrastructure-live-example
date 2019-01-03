# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an gcs bucket
  remote_state {
    backend = "gcs"
    config {
      bucket         = "terragrunt-eng-tools-terraform-state"
      prefix         = "${path_relative_to_include()}/terraform.tfstate"
      project        = "eng-tools"
    }
  }
  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
          "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}"
      ]
    }
  }
}
