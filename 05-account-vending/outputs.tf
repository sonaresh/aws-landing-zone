output "created_accounts" {

  value = {
    for name, acct in local.accounts_normalized :

    name => {
      email = acct.email
      class = acct.class
      ou_id = local.account_ou_id[name]
    }

  }

}