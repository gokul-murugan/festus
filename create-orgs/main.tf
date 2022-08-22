module "create_ou" {
  source = "../modules/aws_organizations/organizational_unit"

  parent_id                = "r-xdx0"
  organizational_unit_name = "Gokul Test"
  ou_tags                  = {}
  service_control_policies_ids = {
    "DenyLeaveOrganization" = {
      policy_id = "p-3fwwihdx" # hardcoded value. Add only after Creating Policy using create_scps module
    }
  }
}

module "create_member_account" {
  source = "../modules/aws_organizations/member_account"

  account_name           = "Gokul 1"
  account_owner_email    = "kavyac24@outlook.com"
  organizational_unit_id = module.create_ou.ou_id
  account_tags           = {}
}
