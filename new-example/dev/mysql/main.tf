variable "vpc_id" {
  type = string
}

# This data block is required if you're using terraform only, and vpc is in a different state file.
# You wouldn't need the vpc_id as an input variable.
# The output would change to value = data.terraform_remote_state.vpc.vpc_id or something.
#
# The issue with this is that you'd have to deploy things in the correct order. Even though you don't have to input
# variables, you still have to know the dependency tree.
# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "my-state-bucket"
#     key    = "vpc/terraform.tfstate"
#   }
# }

output "db_domain" {
  value = "domain.${var.vpc_id}"
}
