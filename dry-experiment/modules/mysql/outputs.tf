output "primary_id" {
  value = random_string.mock_db.result
}

output "primary_endpoint" {
  value = "${var.name}.${random_string.mock_db.result}.us-east-1.rds.amazonaws.com"
}

output "port" {
  value = 3306
}