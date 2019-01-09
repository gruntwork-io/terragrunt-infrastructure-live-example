terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::ssh://git@github.com/RitualCo/terragrunt-infrastructure-modules.git//gcp/ribot?ref=v0.0.4"
  }
}
