variable "name_prefix" {
  type = string
}

variable "child_accounts" {
  type = map(object({
    email           = string
    is_logs_account = bool
  }))
}

variable "cloudtrail_bucket_name" {
  type = string
}

variable "config_bucket_name" {
  type = string
}

variable "accounts_json_path" {
  type = string
}