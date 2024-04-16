# Example of how to integrate Terragrunt with Terramate

This repository is a fork of the [Terragrunt reference architecture](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example)
to demonstrate how to enhance Terragrunt with Terramate by adding:

- **Orchestration with Change Detection** to automatically detect and execute modules that contain changes only using
`terragrunt plan` and `terragrunt apply`.
- **GitOps automation workflows in GitHub Actions** (or any other CI/CD) to automate Terragrunt with plan previews in
Pull Requests in your CI/CD without requiring any additional tooling such as Atlantis.
- **Drift detection and reconciliation** to keep your Terragrunt modules drift-free with scheduled workflows in GitHub actions.
- **Observability and Visibility** to understand the health and infrastructure managed in your modules.

Please read our [Terramate and Terragrunt guide](https://terramate.io/rethinking-iac/how-terramate-adds-superpowers-to-terragrunt-in-just-5-minutes/) to learn more about how this repository works and how you can use Terramate to supercharge Terragrunt.

## Terragrunt reference architecture documentation

To learn more about Terragrunt and the infrastructure-live example, please look at the [terragrunt-infrastructure-live-example](https://github.com/gruntwork-io/terragrunt-infrastructure-live-example) repository.
