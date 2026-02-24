output "permission_boundary_arns" {
  value = {
    workload = aws_iam_policy.boundary_workload.arn
    sandbox  = aws_iam_policy.boundary_sandbox.arn
  }
}

output "baseline_roles" {
  value = {
    breakglass     = aws_iam_role.breakglass.arn
    audit_readonly = aws_iam_role.audit_readonly.arn
  }
}
