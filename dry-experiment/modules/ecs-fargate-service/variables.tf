variable "name" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "docker_image_version" {
  type = string
}

variable "replicas" {
  type = number
}

variable "env_vars" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}