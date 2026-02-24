# Shared variables

variable "org" {
  type = string
}

variable "program" {
  type    = string
  default = "lz"
}

variable "owner" {
  type = string
}

variable "cost_center" {
  type    = string
  default = "lab"
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}

variable "primary_region" {
  type    = string
  default = "us-east-1"
}

variable "dr_region" {
  type    = string
  default = "us-east-2"
}

variable "security_admin_account_id" {
  description = "Delegated admin account ID"
  type        = string
}

variable "enable_security_hub" {
  description = "Enable Security Hub org admin"
  type        = bool
  default     = false
}