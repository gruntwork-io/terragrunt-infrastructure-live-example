output "endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "db_name" {
  value = aws_db_instance.mysql.name
}

output "arn" {
  value = aws_db_instance.mysql.arn
}
