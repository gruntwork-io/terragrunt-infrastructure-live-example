/*
 Opening all traffic within SG for VPC only


resource "aws_security_group" "default-vpc-sg" {
   name = "default-infra-vpc-sg"
   vpc_id = "${aws_vpc.kafka_vpc.id}"

   // allows traffic from the SG itself for tcp
   ingress {
       from_port = 0
       to_port = 65535
       protocol = "tcp"
       self = true
   }

   // allows traffic from the SG itself for udp
   ingress {
       from_port = 0
       to_port = 65535
       protocol = "udp"
       self = true
   }


   ingress {
       from_port = 6783
       to_port = 6783
       protocol = "tcp"
       self = true
       cidr_blocks = ["${var.vpc_cidr}"]
   }

   ingress {
       from_port = 6783
       to_port = 6783
       protocol = "udp"
       self = true
       cidr_blocks = ["${var.vpc_cidr}"]
   }

   ingress {
       from_port = 6784
       to_port = 6784
       protocol = "udp"
       self = true
       cidr_blocks = ["${var.vpc_cidr}"]
   }

   egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["${var.vpc_cidr}"]
   }

}
*/
