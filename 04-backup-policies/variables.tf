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

variable "ou_workloads_prod_id" {
  type = string
}

variable "ou_workloads_nonprod_id" {
  type = string
}

variable "ou_sandbox_id" {
  type = string
}

variable "backup_retention_days_prod" {
  type = number
}

variable "backup_retention_days_nonprod" {
  type = number
}

variable "backup_retention_days_sandbox" {
  type = number
}

variable "enable_backup_policies" {
  description = "Enable org backup policies"
  type        = bool
}