terramate {
  config {
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
