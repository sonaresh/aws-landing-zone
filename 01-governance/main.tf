data "aws_organizations_organization" "current" {}

locals {
  primary_region = var.primary_region
  dr_region      = var.dr_region
}

resource "aws_organizations_policy" "scp_region_allowlist" {
  name        = "${var.org}-${var.program}-scp-region-allowlist"
  description = "Deny actions outside approved regions (primary + DR)"
  type        = "SERVICE_CONTROL_POLICY"
  content = templatefile("${path.module}/scp/region-allowlist.json", {
    primary_region = local.primary_region
    dr_region      = local.dr_region
  })

  tags = local.common_tags
}

resource "aws_organizations_policy" "scp_protect_logging" {
  name        = "${var.org}-${var.program}-scp-protect-logging"
  description = "Protect CloudTrail/Config from being disabled"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scp/protect-logging.json")

  tags = local.common_tags
}

resource "aws_organizations_policy" "scp_enforce_encryption" {
  name        = "${var.org}-${var.program}-scp-enforce-encryption"
  description = "Deny unencrypted EBS volumes (lab-safe example)"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scp/enforce-encryption.json")

  tags = local.common_tags
}

resource "aws_organizations_policy" "scp_deny_dangerous_iam" {
  name        = "${var.org}-${var.program}-scp-deny-dangerous-iam"
  description = "Deny IAM primitives commonly used in privilege escalation (starter)"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scp/deny-dangerous-iam.json")

  tags = local.common_tags
}

resource "aws_organizations_policy" "scp_quarantine" {
  name        = "${var.org}-${var.program}-scp-quarantine"
  description = "Quarantine OU: deny everything (use with care)"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scp/quarantine.json")

  tags = local.common_tags
}

# Attachments (you can tune which SCPs go to which OUs)
resource "aws_organizations_policy_attachment" "attach_region_allowlist_root" {
  policy_id = aws_organizations_policy.scp_region_allowlist.id
  target_id = data.aws_organizations_organization.current.roots[0].id
}

resource "aws_organizations_policy_attachment" "attach_protect_logging_prod" {
  policy_id = aws_organizations_policy.scp_protect_logging.id
  target_id = var.ou_workloads_prod_id
}

resource "aws_organizations_policy_attachment" "attach_protect_logging_nonprod" {
  policy_id = aws_organizations_policy.scp_protect_logging.id
  target_id = var.ou_workloads_nonprod_id
}

resource "aws_organizations_policy_attachment" "attach_encryption_prod" {
  policy_id = aws_organizations_policy.scp_enforce_encryption.id
  target_id = var.ou_workloads_prod_id
}

resource "aws_organizations_policy_attachment" "attach_deny_dangerous_iam_security" {
  policy_id = aws_organizations_policy.scp_deny_dangerous_iam.id
  target_id = var.ou_security_id
}

resource "aws_organizations_policy_attachment" "attach_quarantine" {
  policy_id = aws_organizations_policy.scp_quarantine.id
  target_id = var.ou_quarantine_id
}
