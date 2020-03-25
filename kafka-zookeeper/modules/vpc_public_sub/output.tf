output "vpc_id" {
  value = "${aws_vpc.kafka_vpc.id}"
}

output "aws_pub_subnet_id" {
  value = ["${aws_subnet.public-subnet.*.id}"]
}

output "aws_pub_subnet_id_str" {
  value = "${join(",",aws_subnet.public-subnet.*.id)}"
}

