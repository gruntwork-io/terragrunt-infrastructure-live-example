/*
-----------------------------------------------------------------
- This deploys entire application stack
- Environment variable will control the naming convention
- Setup creds and region via env variables
- For more details: https://www.terraform.io/docs/providers/aws
-----------------------------------------------------------------
Notes:
 - control_cidr changes for different modules
 - Instance class also changes for different modules
 - Bastion should be minimum t2.medium as it would be executing config scripts
 - Default security group is added where traffic is supposed to flow between VPC
 */

/********************************************************************************/
provider "aws" {
  region = "${var.region}"
}


/****
/********************************************************************************/

module "vpc" {
   source                   = "../modules/vpc"
   azs                      = "${var.azs}"
   vpc_cidr                 = "${var.vpc_cidr}"
   public_sub_cidr          = "${var.public_sub_cidr}"
   private_sub_cidr         = "${var.private_sub_cidr}"
   enable_dns_hostnames     = true
   vpc_name                 = "${var.vpc_name}-${var.environment}"
   environment              = "${var.environment}"
}

#resource "template_file" "kafka" {
#  template = "kafka_userdata.tpl"
#  vars {
#    region= "${var.region}"
#  }
#}

module "kafka" {
   source                 = "../modules/kafka"
   vpc_id                 = "${module.vpc.vpc_id}"
   #aws_pub_subnet_id     = "${module.vpc.aws_pub_subnet_id}"
   aws_pub_subnet_id_str  = "${module.vpc.aws_pub_subnet_id_str}"
   region                 = "${var.region}"
   azs                    = "${var.azs}"
   aws_key_name           = "${var.aws_key_name}"
   vpc_cidr               = "${var.vpc_cidr}"
   environment            = "${var.environment}"
   kafka_image            = "${var.kafka_image}"
   kafka_instance_type    = "${var.kafka_instance_type}"
   kafka_instance_count   = "${var.kafka_instance_count}"
   kafka_cluster_size     = "${var.kafka_cluster_size}"
   kafka_lc               = "${var.kafka_lc}"
   kafka_service_name     = "${var.kafka_service_name}"
   zookeeper_service_name = "${var.zookeeper_service_name}"
   zone_name              = "${var.zone_name}"
   rec_name               = "${var.rec_name}"
#   user_data_base64      = base64encode(local.userdata)
}

module "zookeeper" {
   source                   = "../modules/zookeeper"
   vpc_id                   = "${module.vpc.vpc_id}"
   #aws_pub_subnet_id       = "${module.vpc.aws_pub_subnet_id}"
   aws_pub_subnet_id_str    = "${module.vpc.aws_pub_subnet_id_str}"
   region                   = "${var.region}"
   azs                      = "${var.azs}"
   aws_key_name             = "${var.aws_key_name}"
   vpc_cidr                 = "${var.vpc_cidr}"
   environment              = "${var.environment}"
   zookeeper_image          = "${var.zookeeper_image}"
   zookeeper_instance_type  = "${var.zookeeper_instance_type}"
   zookeeper_instance_count = "${var.zookeeper_instance_count}"
   zookeeper_cluster_size   = "${var.zookeeper_cluster_size}"
   zookeeper_lc             = "${var.zookeeper_lc}"
   zookeeper_sg             = "${module.kafka.kafka_sg}"
   zookeeper_profile_iam_id = "${module.kafka.kafka_profile_iam_id}"
   kafka_service_name       = "${var.kafka_service_name}"
   zookeeper_service_name   = "${var.zookeeper_service_name}"
   zone_name                = "${var.zone_name}"
   rec_name                 = "${var.rec_name}"
}

locals {
  userdata = <<-USERDATA
    #!/bin/bash
    echo hello
    region="${var.region}"
    region2=${var.region}
  USERDATA
}
