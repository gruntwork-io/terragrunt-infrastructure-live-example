variable "name_prefix" {
  type = string
}

variable "config_bucket_name" {
  type = string
}

variable "cloudtrail_bucket_name" {
  type = string
}

variable "allow_read_only_access_from_other_account_arns" {
  type = list(string)
}

variable "allow_full_access_from_other_account_arns" {
  type = list(string)
}