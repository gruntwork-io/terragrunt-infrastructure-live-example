include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = "${dirname(find_in_parent_folders())}/_env/mysql.hcl"
  expose         = true
  merge_strategy = "deep"
}

terraform {
  # source = "${include.env.locals.source_base_url}?ref=v0.2.0"
  source = include.env.locals.source_base_url
}

inputs = {
  instance_type = "db.t3.large"
}
