output "workload_bucket" {
  value = aws_s3_bucket.workload_data.bucket
}

output "app_role_arn" {
  value = aws_iam_role.app_role.arn
}