/*
- kafka_sg
- All traffic in vpc is open since we do not know what all ports we may
  have to open
 */
resource "aws_security_group" "kafka_sg" {
   name = "kafka_sg"
   vpc_id = "${var.vpc_id}"

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
      from_port = 0
      to_port = 65535
      protocol = "udp"
      cidr_blocks = ["${var.vpc_cidr}"]
   }

   ingress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["${var.vpc_cidr}"]
   }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.193.88.69/32"]
  }
   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}
