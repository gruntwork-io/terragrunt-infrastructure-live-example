module "account_baseline" {
  source = "..\/account-baseline-app"

  name_prefix            = var.env_name
  config_bucket_name     = var.config_bucket_name
  cloudtrail_bucket_name = var.cloudtrail_bucket_name

  allow_read_only_access_from_other_account_arns = [var.security_account_id]
  allow_full_access_from_other_account_arns      = [var.security_account_id]
}

module "vpc" {
  source = "..\/vpc"

  vpc_name         = "vpc-${var.env_name}"
  cidr_block       = var.env_configuration.vpc.cidr_block
  num_nat_gateways = var.env_configuration.vpc.num_nat_gateways
}

module "mysql" {
  source = "..\/mysql"

  name          = "mysql-${var.env_name}"
  instance_type = var.env_configuration.mysql.instance_type
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_persistence_subnet_ids
}

module "frontend" {
  source = "..\/ecs-fargate-service"

  name                 = "frontend-${var.env_name}"
  docker_image         = var.env_configuration.frontend_app.image
  docker_image_version = var.env_configuration.frontend_app.version
  replicas             = var.env_configuration.frontend_app.replicas
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_app_subnet_ids

  env_vars = {
    BACKEND_ENDPOINT = module.backend.service_endpoint
  }
}

module "backend" {
  source = "..\/ecs-fargate-service"

  name                 = "backend-${var.env_name}"
  docker_image         = var.env_configuration.backend_app.image
  docker_image_version = var.env_configuration.backend_app.version
  replicas             = var.env_configuration.backend_app.replicas
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_app_subnet_ids

  env_vars = {
    DB_ENDPOINT = module.mysql.primary_endpoint
    DB_PORT     = module.mysql.port
  }
}
