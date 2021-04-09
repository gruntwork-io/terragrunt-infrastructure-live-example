output "vpc_id" {
  value = "vpc-${random_string.mock_vpc.result}"
}

output "public_subnet_ids" {
  value = [for idx, mock_subnet in random_string.mock_subnets : "subnet-${mock_subnet.result}" if idx < var.num_availability_zones]
}

output "private_app_subnet_ids" {
  value = [for idx, mock_subnet in random_string.mock_subnets : "subnet-${mock_subnet.result}" if idx >= var.num_availability_zones && idx < (var.num_availability_zones * 2)]
}

output "private_persistence_subnet_ids" {
  value = [for idx, mock_subnet in random_string.mock_subnets : "subnet-${mock_subnet.result}" if idx >= (var.num_availability_zones * 2)]
}