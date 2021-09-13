include "root" {
  path = find_in_parent_folders("common.hcl")
}

include "env" {
  path   = "${dirname(find_in_parent_folders("common.hcl"))}/_env/account-baseline-app.hcl"
  expose = true
}

terraform {
  source = include.env.locals.source_base_url
}
