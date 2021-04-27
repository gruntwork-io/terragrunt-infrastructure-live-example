include {
  path = "../../../_env/vpc.hcl"
}

terraform {
  source = "../../../..//modules/vpc"
}

inputs = {
  cidr_block = "10.0.0.0/16"
}