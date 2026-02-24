# Delegated admin scaffolding (run from Management account with org permissions)

# GuardDuty delegated admin
resource "aws_guardduty_organization_admin_account" "gd_admin" {
  admin_account_id = var.security_admin_account_id
}

# Security Hub delegated admin (optional)
resource "aws_securityhub_organization_admin_account" "sh_admin" {
  count            = var.enable_security_hub ? 1 : 0
  admin_account_id = var.security_admin_account_id
}

# NOTE:
# - Enabling GuardDuty detectors in every account is typically done from the delegated admin account,
#   often via StackSets/AFT customization. For lab simplicity, we stop at delegated admin registration.
