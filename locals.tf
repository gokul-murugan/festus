data "aws_caller_identity" "current_account" {

}

locals {
  account_id = data.aws_caller_identity.current_account.account_id

  CloudCraftAccessRolePolicies        = ["ReadOnlyAccess"]
  CustodianAgentAccessRolePolicies    = ["AdministratorAccess"]
  Ec2SchedulerExecRolePolicies        = ["AdministratorAccess"]
  SAMLAdministratorAccessRolePolicies = ["AdministratorAccess"]
  SAMLPowerUserAccessRolePolicies     = ["PowerUserAccess"]
  AWSBackupServiceRolePolicies = [
    "service-role/AWSBackupServiceRolePolicyForRestores",
    "service-role/AWSBackupServiceRolePolicyForRestores"
  ]
  SAMLDatabaseAdministratorRolePolicies = [
    "AdministratorAccess",
    "AmazonRDSFullAccess",
    "AmazonEC2FullAccess",
    "AmazonS3FullAccess",
    "job-function/DatabaseAdministrator",
    "CloudWatchFullAccess",
    "AWSSupportAccess",
    "AWSStepFunctionsFullAccess",
    "CloudWatchEventsFullAccess",
    "AWSLambda_FullAccess"
  ]
  SAMLInfoSecAdministratorRolePolicies = [
    "job-function/SupportUser",
    "AmazonInspectorFullAccess",
    "ReadOnlyAccess"
  ]
  SAMLNetworkAdministratorRolePolicies = [
    "AmazonEC2FullAccess",
    "CloudWatchReadOnlyAccess",
    "job-function/NetworkAdministrator",
    "AWSSupportAccess",
    "AWSNetworkManagerFullAccess"
  ]
  SAMLSupportUserRolePolicies = [
    "job-function/SupportUser",
    "ReadOnlyAccess"
  ]
  SAMLSystemAdministratorRolePolicies = [
    "job-function/SystemAdministrator",
    "AWSSupportAccess",
    "AWSLambda_FullAccess"
  ]
}