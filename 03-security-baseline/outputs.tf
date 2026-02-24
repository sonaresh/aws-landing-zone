output "delegated_admin" {
  value = {
    guardduty_admin_account   = aws_guardduty_organization_admin_account.gd_admin.admin_account_id
    securityhub_admin_account = var.enable_security_hub ? aws_securityhub_organization_admin_account.sh_admin[0].admin_account_id : null
  }
}
