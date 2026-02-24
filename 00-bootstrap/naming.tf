locals {
  # Global naming
  org     = var.org
  program = var.program

  # Standard tagset (apply to everything you create)
  common_tags = merge({
    Owner      = var.owner
    CostCenter = var.cost_center
    ManagedBy  = "terraform"
    Program    = local.program
    Org        = local.org
  }, var.extra_tags)
}
