module "create_member_account" {
  source = "../../../Modules/aws_organizations/member_account"

  member_accounts = {
    Account_1 = { # Account name
      account_owner_email    = "kivec56756@vasqa.com"
      organizational_unit_id = module.create_ou.ou_id
      account_tags           = {}
    },
    Account_2 = { # Account name
      account_owner_email    = "momlevukki@vusra.com"
      organizational_unit_id = module.create_ou.ou_id
      account_tags           = {}
    }
  }

}