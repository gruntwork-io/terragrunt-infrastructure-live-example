include {
  path = "../../../env/app/terragrunt.hcl"
}

inputs = {
  ami           = "ami-abcd1234"
  instances     = 2
  instance_type = "t3.micro"
}