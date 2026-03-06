locals {

  ############################################################
  # Standard tags
  ############################################################

  common_tags = {
    Owner      = var.owner
    CostCenter = var.cost_center
    ManagedBy  = "terraform"
    Program    = var.program
    Org        = var.org
    Layer      = "account-vending"
  }

  ############################################################
  # OU lookup table
  ############################################################

  ou_map = {
    infrastructure    = var.ou_infrastructure_id
    security          = var.ou_security_id
    workloads-prod    = var.ou_workloads_prod_id
    workloads-nonprod = var.ou_workloads_nonprod_id
    sandbox           = var.ou_sandbox_id
    quarantine        = var.ou_quarantine_id
  }

  ############################################################
  # Normalize accounts
  ############################################################

  accounts_normalized = {
    for name, acct in var.accounts :
    name => {
      email = acct.email
      class = lower(acct.class)
    }
  }

  ############################################################
  # Resolve class safely
  ############################################################

  account_class = {
    for name, acct in local.accounts_normalized :
    name => lookup(var.account_classes, acct.class, null)
  }

  ############################################################
  # Resolve OU safely
  ############################################################

  account_ou_id = {
    for name, acct in local.accounts_normalized :
    name => lookup(
      local.ou_map,
      try(local.account_class[name].ou, ""),
      null
    )
  }

  ############################################################
  # Resolve SCPs safely
  ############################################################

  account_scps = {
    for name, acct in local.accounts_normalized :
    name => try(local.account_class[name].attach_scps, [])
  }

  ############################################################
  # Account tags
  ############################################################

  account_tags = {
    for name, acct in local.accounts_normalized :
    name => merge(
      local.common_tags,
      {
        AccountName  = name
        AccountClass = acct.class
      }
    )
  }

}