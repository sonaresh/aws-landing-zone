variable "org" {
  description = "Short org prefix used in names/tags (e.g., lab)"
  type        = string
}

variable "program" {
  description = "Program prefix used in names/tags (e.g., lz)"
  type        = string
  default     = "lz"
}

variable "owner" {
  description = "Owner tag value"
  type        = string
}

variable "cost_center" {
  description = "Cost center tag value (lab-friendly)"
  type        = string
  default     = "lab"
}

variable "extra_tags" {
  description = "Any additional tags to apply"
  type        = map(string)
  default     = {}
}

variable "primary_region" {
  description = "Primary region"
  type        = string
  default     = "us-east-1"
}

variable "dr_region" {
  description = "DR region"
  type        = string
  default     = "us-east-2"
}
