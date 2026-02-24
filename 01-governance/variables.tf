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

variable "ou_security_id" {
  type = string
}

variable "ou_infrastructure_id" {
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

variable "ou_quarantine_id" {
  type = string
}

variable "enable_rcp_policies" {
  type    = bool
  default = false
}

locals {
  common_tags = merge({
    Owner      = var.owner
    CostCenter = var.cost_center
    ManagedBy  = "terraform"
    Program    = var.program
    Org        = var.org
  }, var.extra_tags)
}

 