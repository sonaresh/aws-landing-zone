locals {
  common_tags = {
    Owner      = var.owner
    CostCenter = var.cost_center
    ManagedBy  = "terraform"
    Program    = var.program
    Org        = var.org
    Layer      = "enterprise-advanced"
  }

  regions = distinct([var.primary_region, var.dr_region])
}