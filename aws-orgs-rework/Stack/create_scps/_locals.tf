locals {

  # Policies
  DenyMarketplaceSubscribe                                    = module.create_service_control_policies.policy_ids[0].DenyMarketplaceSubscribe.id
  DenyResourceCreationWithoutValidTagkeysEc2                  = module.create_service_control_policies.policy_ids[0].DenyRestrictResourceCreationWithoutValidTagkeysEc2.id
  DenyIAMResourceCreationWithoutValidTagKeys                  = module.create_service_control_policies.policy_ids[0].DenyIAMResourceCreationWithoutValidTagKeys.id
  DenyUnauthorizedWexRegions                                  = module.create_service_control_policies.policy_ids[0].DenyUnauthorizedWexRegions.id
  DenyReservedInstances                                       = module.create_service_control_policies.policy_ids[0].DenyReservedInstances.id
  DenyLeaveOrganization                                       = module.create_service_control_policies.policy_ids[0].DenyLeaveOrganization.id
  DenyRestrictResourceCreationWithoutValidTagKeysEc2Scheduler = module.create_service_control_policies.policy_ids[0].DenyRestrictResourceCreationWithoutValidTagKeysEc2Scheduler.id

  # Sandbox OU and related Member Accounts
  sandbox_ou_id = "ou-xdx0-uwx4toon"
  account_1_id  = "377878235596"
  account_2_id  = "194270661208"

}