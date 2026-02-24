variable "org" {
  type = string
}

variable "program" {
  type = string
}

variable "owner" {
  type = string
}

variable "cost_center" {
  type = string
}

variable "primary_region" {
  type = string
}

variable "dr_region" {
  type = string
}

variable "breakglass_principal_arns" {
  description = "IAM principals allowed to assume break-glass role"
  type        = list(string)
}