terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::ssh://git@github.com/RitualCo/terragrunt-infrastructure-modules.git//gcp/rite-hubot?ref=v0.0.3"
  }
}
