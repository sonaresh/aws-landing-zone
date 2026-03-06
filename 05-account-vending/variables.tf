###############################################################
# 05-account-vending/variables.tf
#
# Account vending – class-based enterprise model
###############################################################

#############################
# Global Metadata
#############################

variable "org" {
  description = "Organization short name"
  type        = string
}

variable "program" {
  description = "Program or landing zone identifier"
  type        = string
}

variable "owner" {
  description = "Platform owner"
  type        = string
}

variable "cost_center" {
  description = "Cost center for tagging"
  type        = string
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
}

#############################
# OU IDs
#############################

variable "ou_infrastructure_id" {
  type = string
}

variable "ou_security_id" {
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

#############################
# SCP Policy IDs
#############################

# Example:
# scp_policy_ids = {
#   region       = "p-xxxx"
#   logging      = "p-xxxx"
#   encryption   = "p-xxxx"
#   iam          = "p-xxxx"
#   quarantine   = "p-xxxx"
# }

variable "scp_policy_ids" {
  description = "Map of SCP short name to policy ID"
  type        = map(string)
}

#############################
# Account Class Definitions
#############################

variable "account_classes" {
  description = "Defines class behavior (OU + SCP matrix)"
  type = map(object({
    ou              = string
    attach_scps     = list(string)
    suspend_allowed = bool
  }))
}

#############################
# Account Requests
#############################

variable "accounts" {
  description = "Accounts to create"
  type = map(object({
    email = string
    class = string
  }))
}

#############################
# Default Access Role
#############################

variable "account_access_role_name" {
  description = "Role created inside new account for org access"
  type        = string
  default     = "OrganizationAccountAccessRole"
}