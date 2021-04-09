variable "name_prefix" {
  type = string
}

variable "config_bucket_name" {
  type = string
}

variable "cloudtrail_bucket_name" {
  type = string
}

variable "iam_users" {
  type = map(object({
    groups  = list(string)
    pgp_key = string
  }))
}