resource "random_string" "mock_aws_organization" {
  for_each = var.child_accounts

  keepers = {
    name  = each.key
    email = each.value.email
  }

  length  = 12
  special = false
  lower   = false
  number  = true
  upper   = false
}

resource "local_file" "accounts_json" {
  filename = var.accounts_json_path
  content = jsonencode(local.child_accounts)
}

locals {
  child_accounts = { for name, id in random_string.mock_aws_organization : name => id.result }
}