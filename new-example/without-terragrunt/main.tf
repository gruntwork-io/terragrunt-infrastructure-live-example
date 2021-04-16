# This is using terraform only, and if everything is in a single state file.

module "vpc" {
  source = "./vpc"
  name   = "my-vpc"
}

module "mysql" {
  source     = "./mysql"
  vpc_id     = module.vpc.vpc_id
  depends_on = module.vpc
}

module "app" {
  source    = "./app"
  vpc_id    = module.vpc.vpc_id
  db_domain = module.mysql.db_domain
}
