/*
 Variables for deploying stack
--------------------------------
*/

// ## General Variables
region            = "us-east-1"
azs               = ["us-east-1a","us-east-1b","us-east-1c"]
vpc_name          = "Kafka-Infra"
vpc_cidr          = "192.168.0.0/16"
environment       = "dev"

/* Classes of instances - has to change based on environment
- Please choose between the following only
- [test|dev|qa|stage]
*/

# AZs are combintation of az length + subnet cidrs
public_sub_cidr   = ["192.168.0.0/24","192.168.1.0/24"]
private_sub_cidr  = ["192.168.3.0/24","192.168.4.0/24"]

// AWS Key Pair //
aws_key_name = "sai-key.pem"

// Kafka Variables //
kafka_lc             = "Kafka_LC"
kafka_image          = "ami-08bc77a2c7eb2b1da" 
kafka_instance_type  = "t2.micro"
kafka_instance_count = 1
kafka_cluster_size   = 1
// Tags //
kafka_service_name   = "kafka"


// Zookeeper Variables //
zookeeper_lc             = "Zookeeper_LC"
zookeeper_image          = "ami-08bc77a2c7eb2b1da" 
zookeeper_instance_type  = "t2.micro"
zookeeper_instance_count = 1
zookeeper_cluster_size   = 1
zookeeper_service_name   = "zookeeper"

// Route 53 //
zone_name = "sai-test4.com"
rec_name  = "kafka.sai.test4.com"


