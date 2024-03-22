terramate {
  config {
    # Configure the namespace of your Terramate Cloud organization
    cloud {
      organization = "terramate-demo"
    }

    experiments = [
      "terragrunt",
    ]

    git {
      # Git configuration
      default_remote = "origin"

      # Safeguard
      check_untracked   = false
      check_uncommitted = false
      check_remote      = false
    }
  }
}
