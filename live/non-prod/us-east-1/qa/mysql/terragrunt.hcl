locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../modules/mysql"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name           = "mysql_${local.env}"
  instance_class = "db.t2.micro"

  allocated_storage = 20
  storage_type      = "standard"

  master_username = "admin"
  master_password = "hdje292i924j8er2jj"
  # TODO: To avoid storing your DB password in the code, set it as the environment variable TF_VAR_master_password
}
