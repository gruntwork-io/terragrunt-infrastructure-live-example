/*
   Variables for bastion
*/

variable "region" {}
variable "azs" {
    default = []
}

variable "environment" {}

variable "vpc_id" {}
#variable "aws_pub_subnet_id" {}
variable "aws_pub_subnet_id_str" {}
variable "vpc_cidr" {}

variable "aws_key_name" {}

variable "kafka_image" {}
variable "kafka_instance_type" {}
variable "kafka_instance_count" {}
variable "kafka_cluster_size" {}
variable "kafka_lc" {}

// Tags //
variable "kafka_service_name" {}
variable "zookeeper_service_name" {}
// Route 53 //
variable "zone_name" {}
variable "rec_name" {}
