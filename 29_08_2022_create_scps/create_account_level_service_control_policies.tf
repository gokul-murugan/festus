module "create_service_control_policies" {
  source = "../modules/aws_organizations/service_control_policies"
  service_control_policies = {
    "DenyLeaveOrganization" = {
      description = "Restrict Access to Leave Organization"
      policy_json = data.aws_iam_policy_document.deny_leave_orgs.json
    },
    "UnauthorizedWexRegionsdeny" = {
      description = "Deny Regions not appropirate to WEX Policy"
      policy_json = data.aws_iam_policy_document.Deny_Regions_not_appropriate_to_WEX_policy.json
    },
    "MarketplaceSubscribedeny" = {
      description = "Restrict Marketplace Purchases"
      policy_json = data.aws_iam_policy_document.Restrict_Marketplace_purchases_deny.json
    },
    "DenyIAMResourceCreationWithoutValidTagKeys" = {
      description = "Restrict To Create Resources Without Valid Tag Keys"
      policy_json = data.aws_iam_policy_document.Deny_IAMResource_Creation_Without_Valid_Tag_Keys.json
    },
    "DenyRestrictResourceCreationWithoutValidTagkeysEc2" = {
      description = "Restrict To Create Resources Without Valid Tag Keys EC2"
      policy_json = data.aws_iam_policy_document.Deny_Restrict_Resource_creation_without_Valid_Tag_keys_Ec2.json
    },
    "DenyReservedInstances" = {
      description = "Restrict Reserved Instances"
      policy_json = data.aws_iam_policy_document.Deny_Reserved_Instance.json
    },
    "DenyRestrictResourceCreationWithoutValidTagKeysEc2Schedular" = {
      description = "Restrict Resource Creation Without Valid Tag Keys Ec2 Scheduler"
      policy_json = data.aws_iam_policy_document.Deny_Restrict_Resource_creation_without_Valid_Tag_keys_Ec2_Scheduler.json
    }


  }
}