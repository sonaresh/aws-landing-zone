output "scp_ids" {
  value = {
    region_allowlist   = aws_organizations_policy.scp_region_allowlist.id
    protect_logging    = aws_organizations_policy.scp_protect_logging.id
    enforce_encryption = aws_organizations_policy.scp_enforce_encryption.id
    deny_dangerous_iam = aws_organizations_policy.scp_deny_dangerous_iam.id
    quarantine         = aws_organizations_policy.scp_quarantine.id
  }
}
