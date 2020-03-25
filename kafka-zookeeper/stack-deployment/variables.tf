/*
   Variables for all modules
*/


// Generic
variable "region" {}
variable "azs" {
    default = []
}

// VPC
variable "environment" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_sub_cidr" {
     default = []
}
variable "private_sub_cidr" {
     default = []
}

// Key pair //
variable "aws_key_name" {}

// Kafka //
variable "kafka_image" {}
variable "kafka_instance_type" {}
variable "kafka_instance_count" {}
variable "kafka_cluster_size" {}
variable "kafka_lc" {}

// zookeeper //
variable "zookeeper_image" {}
variable "zookeeper_instance_type" {}
variable "zookeeper_instance_count" {}
variable "zookeeper_cluster_size" {}
variable "zookeeper_lc" {}

// Tags //
variable "kafka_service_name" {}
variable "zookeeper_service_name" {}
// Route 53 //
variable "zone_name" {}
variable "rec_name" {}

#variable "user_data_base64" {
#  type        = string
#  description = "The Base64-encoded user data to provide when launching the instances"
#  default     = ""
#}
