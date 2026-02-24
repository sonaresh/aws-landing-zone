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

variable "security_admin_account_id" {
  type = string
}

# Feature toggles (keep OFF for lab until ready)
variable "enable_security_lake" {
  description = "Enable AWS Security Lake (can be expensive)"
  type        = bool
  default     = false
}

variable "enable_firewall_manager" {
  description = "Enable AWS Firewall Manager (setup only; policies optional)"
  type        = bool
  default     = false
}

variable "enable_fms_delegated_admin" {
  description = "Register delegated admin for Firewall Manager (recommended in org setups)"
  type        = bool
  default     = false
}

variable "enable_security_lake_delegated_admin" {
  description = "Register delegated admin for Security Lake (recommended in org setups)"
  type        = bool
  default     = false
}