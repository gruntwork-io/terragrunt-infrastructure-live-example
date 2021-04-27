include {
  path = "../../../_env/mysql.hcl"
}

terraform {
  source = "../../../..//modules/mysql"
}

inputs = {
  instance_type = "db.t3.micro"
}