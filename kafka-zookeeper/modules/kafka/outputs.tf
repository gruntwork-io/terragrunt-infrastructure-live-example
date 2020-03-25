output "kafka_sg" {
   value = "${aws_security_group.kafka_sg.id}"
}

output "kafka_profile_iam_id" {
   value = "${aws_iam_instance_profile.kafka_profile.id}"
}