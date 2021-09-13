include "root" {
  path = find_in_parent_folders("common.hcl")
}

include "env" {
  path   = "${dirname(find_in_parent_folders("common.hcl"))}/_env/vpc.hcl"
  expose = true
}

terraform {
  source = include.env.locals.source_base_url
}

inputs = {
  cidr_block       = "10.10.0.0/16"
  num_nat_gateways = 3
}
