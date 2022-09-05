# Attaches SCP to Sandbox OU
module "attach_scp_to_sandbox_ou" {
  source = "../../Modules/aws_organizations/attach_service_control_policies"

  attach_policies = {
    DenyLeaveOrganization = {
      policy_id = local.DenyLeaveOrganization
      target_id = local.sandbox_ou_id
    },
    DenyReservedInstances = {
      policy_id = local.DenyReservedInstances
      target_id = local.sandbox_ou_id
    }
  }
}

# Attaches SCP to All member accounts in the Sandbox OU
module "attach_scp_to_accounts_in_sandbox_ou" {
  source = "../../Modules/aws_organizations/attach_service_control_policies"

  attach_policies = {
    # Member Account 1
    account1_DenyMarketplaceSubscribe = {
      policy_id = local.DenyMarketplaceSubscribe
      target_id = local.account_1_id
    },
    account1_DenyResourceCreationWithoutValidTagkeysEc2 = {
      policy_id = local.DenyResourceCreationWithoutValidTagkeysEc2
      target_id = local.account_1_id
    },
    # Member Account 2
    account1_DenyMarketplaceSubscribe = {
      policy_id = local.DenyMarketplaceSubscribe
      target_id = local.account_1_id
    },
    account1_DenyResourceCreationWithoutValidTagkeysEc2 = {
      policy_id = local.DenyResourceCreationWithoutValidTagkeysEc2
      target_id = local.account_1_id
    }
  }
}