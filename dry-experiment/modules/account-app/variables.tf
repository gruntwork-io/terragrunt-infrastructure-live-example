variable "env_name" {
  type = string
}

variable "env_configuration" {
  type = object({
    vpc = object({
      cidr_block       = string
      num_nat_gateways = number
    })
    mysql = object({
      instance_type = string
    })
    frontend_app = object({
      image    = string
      version  = string
      replicas = number
    })
    backend_app = object({
      image    = string
      version  = string
      replicas = number
    })
  })
}

variable "config_bucket_name" {
  type = string
}

variable "cloudtrail_bucket_name" {
  type = string
}

variable "security_account_id" {
  type = string
}