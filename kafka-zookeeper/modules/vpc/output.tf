output "vpc_id" {
  value = "${aws_vpc.kafka_vpc.id}"
}

output "aws_pub_subnet_id" {
  value = ["${aws_subnet.public-subnet.*.id}"]
}

output "aws_pri_subnet_id" {
  value = ["${aws_subnet.private-subnet.*.id}"]
}

// str ouput values can be used by split functions
// to be used in other resources
output "aws_pri_subnet_id_str" {
  value = "${join(",",aws_subnet.private-subnet.*.id)}"
}

output "aws_pub_subnet_id_str" {
  value = "${join(",",aws_subnet.public-subnet.*.id)}"
}

/*
output "aws_default_sg_id" {
  value = "${aws_security_group.default-vpc-sg.id}"
}
*/
