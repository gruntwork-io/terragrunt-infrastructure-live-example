include {
  path = "../../../env/app/terragrunt.hcl"
}

inputs = {
  ami           = "ami-abcd1234"
  instances     = 3
  instance_type = "t3.large"
}