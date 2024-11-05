variable "account_alias" {
  type = string
}

variable "application_name" {
  type = string
}

variable "subscriber_email_address" {
  type = string
}

variable "public_key" {
  type = string
}

variable "user_data" {
  type = string
}

variable "volume_size" {
  type    = number
  default = 8
}
