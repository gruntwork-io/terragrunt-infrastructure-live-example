/*
   Variables for zookeeper
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

// Key pair //
variable "aws_key_name" {}

// zookeeper //
variable "zookeeper_image" {}
variable "zookeeper_instance_type" {}
variable "zookeeper_instance_count" {}
variable "zookeeper_cluster_size" {}
variable "zookeeper_lc" {}
variable "zookeeper_sg" {}
variable "zookeeper_profile_iam_id" {}

// Tags //
variable "kafka_service_name" {}
variable "zookeeper_service_name" {}
// Route 53 //
variable "zone_name" {}
variable "rec_name" {}
