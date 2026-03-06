###############################################################
# 05-account-vending/main.tf
###############################################################

############################################
# Create Accounts Directly in Target OU
############################################

resource "aws_organizations_account" "accounts" {

  for_each = local.accounts_normalized

  name      = each.key
  email     = each.value.email

  # Place account directly in correct OU
  parent_id = local.account_ou_id[each.key]

  role_name = var.account_access_role_name

  tags = local.account_tags[each.key]

  lifecycle {
    prevent_destroy = true
  }

}

############################################
# Attach SCPs Based on Account Class
############################################

# Build account → SCP matrix

locals {

  account_scp_matrix = flatten([
    for account_name, scp_list in local.account_scps : [
      for scp in scp_list : {
        account = account_name
        scp     = scp
      }
    ]
  ])

}

resource "aws_organizations_policy_attachment" "attach_scps" {

  for_each = {
    for combo in local.account_scp_matrix :
    "${combo.account}::${combo.scp}" => combo
  }

  policy_id = var.scp_policy_ids[each.value.scp]

  target_id = aws_organizations_account.accounts[each.value.account].id

  depends_on = [
    aws_organizations_account.accounts
  ]

}