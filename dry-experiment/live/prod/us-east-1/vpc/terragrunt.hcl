include {
  path = "../../../_env/vpc.hcl"
}

terraform {
  source = "../../../..//modules/vpc"
}

inputs = {
  cidr_block       = "10.10.0.0/16"
  num_nat_gateways = 3
}