locals {
  prod_policy_content    = templatefile("${path.module}/policies/prod-backup-policy.json", {})
  nonprod_policy_content = templatefile("${path.module}/policies/nonprod-backup-policy.json", {})
  sandbox_policy_content = templatefile("${path.module}/policies/sandbox-backup-policy.json", {})
}

resource "aws_organizations_policy" "backup_prod" {
  count       = var.enable_backup_policies ? 1 : 0
  name        = "${var.org}-${var.program}-backup-prod"
  description = "Backup policy for Prod OU (tag-based selection)"
  type        = "BACKUP_POLICY"
  content     = local.prod_policy_content
  tags        = local.common_tags
}

resource "aws_organizations_policy" "backup_nonprod" {
  count       = var.enable_backup_policies ? 1 : 0
  name        = "${var.org}-${var.program}-backup-nonprod"
  description = "Backup policy for NonProd OU (tag-based selection)"
  type        = "BACKUP_POLICY"
  content     = local.nonprod_policy_content
  tags        = local.common_tags
}

resource "aws_organizations_policy" "backup_sandbox" {
  count       = var.enable_backup_policies ? 1 : 0
  name        = "${var.org}-${var.program}-backup-sandbox"
  description = "Backup policy for Sandbox OU (tag-based selection)"
  type        = "BACKUP_POLICY"
  content     = local.sandbox_policy_content
  tags        = local.common_tags
}

resource "aws_organizations_policy_attachment" "attach_prod" {
  count     = var.enable_backup_policies ? 1 : 0
  policy_id = aws_organizations_policy.backup_prod[0].id
  target_id = var.ou_workloads_prod_id
}

resource "aws_organizations_policy_attachment" "attach_nonprod" {
  count     = var.enable_backup_policies ? 1 : 0
  policy_id = aws_organizations_policy.backup_nonprod[0].id
  target_id = var.ou_workloads_nonprod_id
}

resource "aws_organizations_policy_attachment" "attach_sandbox" {
  count     = var.enable_backup_policies ? 1 : 0
  policy_id = aws_organizations_policy.backup_sandbox[0].id
  target_id = var.ou_sandbox_id
}
