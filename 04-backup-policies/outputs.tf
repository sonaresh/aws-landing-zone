output "backup_policy_ids" {
  value = {
    prod    = try(aws_organizations_policy.backup_prod[0].id, null)
    nonprod = try(aws_organizations_policy.backup_nonprod[0].id, null)
    sandbox = try(aws_organizations_policy.backup_sandbox[0].id, null)
  }
}
