# Minimal regional baseline for us-east-2
# Keep this cheap for lab. Add more services later.

resource "aws_cloudwatch_log_group" "lz_log_group" {
  name              = "/us-east-2/${var.org}/${var.program}/landing-zone"
  retention_in_days = 7
  tags              = local.common_tags
}