include {
  path = "../../../_env/mysql.hcl"
}

terraform {
  source = "../../../..//modules/mysql"
}

inputs = {
  instance_type = "db.r4.large"
}