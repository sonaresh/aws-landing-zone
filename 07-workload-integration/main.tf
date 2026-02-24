############################################
# Data Sources
############################################

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "app_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

############################################
# Secure S3 Bucket (Example Workload Resource)
############################################

resource "aws_s3_bucket" "workload_data" {
  bucket = "${var.org}-${var.program}-workload-data-${data.aws_caller_identity.current.account_id}"
  tags   = local.common_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.workload_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

############################################
# Permission Boundary Policy
############################################

resource "aws_iam_policy" "workload_boundary" {
  name = "${var.org}-${var.program}-workload-boundary"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyIAMModification"
        Effect   = "Deny"
        Action   = [
          "iam:*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = local.common_tags
}

############################################
# Application IAM Role (Enforced Boundary)
############################################

resource "aws_iam_role" "app_role" {
  name                 = "${var.org}-${var.program}-app-role"
  assume_role_policy   = data.aws_iam_policy_document.app_assume.json
  permissions_boundary = aws_iam_policy.workload_boundary.arn
  tags                 = local.common_tags
}