output "service_id" {
  value = random_string.mock_ecs_fargate_service.result
}

output "service_endpoint" {
  value = "https://${random_string.mock_ecs_fargate_service.result}.elb.amazonaws.com"
}

output "env_vars" {
  value = var.env_vars
}