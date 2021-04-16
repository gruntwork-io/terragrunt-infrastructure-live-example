dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
}

dependency "mysql" {
  config_path = "${get_terragrunt_dir()}/../mysql"
}

inputs = {
  vpc_id    = dependency.vpc.outputs.vpc_id
  db_domain = dependency.mysql.outputs.db_domain
}
