# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "non-prod"
  aws_account_id = "replaceme" # TODO: replace me with your AWS account ID!
  aws_profile    = "non-prod"
  role_to_assume = "OrganizationAccountAccessRole" # TODO: replace me with a role to assume
}
