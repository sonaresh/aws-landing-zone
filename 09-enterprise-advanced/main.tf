############################################################
# Security Lake IAM Role (Required)
############################################################

resource "aws_iam_role" "security_lake_role" {
  count = var.enable_security_lake ? 1 : 0

  name = "${var.org}-${var.program}-securitylake-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "securitylake.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "security_lake_attach" {
  count      = var.enable_security_lake ? 1 : 0
  role       = aws_iam_role.security_lake_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSecurityLakeMetastoreManager"
}

############################################################
# Security Lake (Regional)
############################################################

resource "aws_securitylake_data_lake" "this" {
  count = var.enable_security_lake ? 1 : 0

  meta_store_manager_role_arn = aws_iam_role.security_lake_role[0].arn

  configuration {
    region = var.primary_region
  }

  tags = local.common_tags
}

############################################################
# Firewall Manager Delegated Admin
############################################################

resource "aws_fms_admin_account" "this" {
  count      = var.enable_firewall_manager ? 1 : 0
  account_id = var.security_admin_account_id
}