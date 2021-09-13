include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = "${dirname(find_in_parent_folders())}/_env/app.hcl"
  expose         = true
  merge_strategy = "deep"
}

terraform {
  # source = "${include.env.locals.source_base_url}?ref=v0.2.0"
  source = include.env.locals.source_base_url
}

inputs = {
  ami           = "ami-abcd1234"
  instances     = 2
  instance_type = "t3.micro"
}
