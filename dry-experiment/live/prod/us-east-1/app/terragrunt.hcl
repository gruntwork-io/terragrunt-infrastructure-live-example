include {
  path = "../../../env/app/terragrunt.hcl"
}

inputs = {
  ami           = "ami-abcd1234"
  instances     = 6
  instance_type = "m4.large"
}