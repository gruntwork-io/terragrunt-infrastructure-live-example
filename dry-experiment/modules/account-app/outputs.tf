output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "vpc_private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "vpc_private_persistence_subnet_ids" {
  value = module.vpc.private_persistence_subnet_ids
}

output "mysql_primary_id" {
  value = module.mysql.primary_endpoint
}

output "mysql_primary_endpoint" {
  value = module.mysql.primary_endpoint
}

output "mysql_port" {
  value = module.mysql.port
}

output "frontend_service_id" {
  value = module.frontend.service_id
}

output "backend_service_id" {
  value = module.backend.service_id
}

output "frontend_service_endpoint" {
  value = module.frontend.service_endpoint
}

output "backend_service_endpoint" {
  value = module.backend.service_endpoint
}