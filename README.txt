├── Stack
│   ├── create-orgs      [Creates every OU individually, so its stored in separate TFSTATE file]
│   │   ├── OU_1         [Creates OU 1 and 'X' number of member accounts that should be part of]
│   │   │   ├── create_account_1.tf
│   │   │   ├── create_account_2.tf
│   │   │   ├── create_ou1.tf
│   │   │   └── provider.tf
│   │   └── OU_2         [Creates OU 2 and 'X' number of member accounts that should be part of]
│   │       ├── create_account_1.tf
│   │       ├── create_account_2.tf
│   │       ├── create_ou2.tf
│   │       └── provider.tf
│   └── create_scps      [Creates all Policies in 1 go and ATTACHes Policies to OU Level and Account Level]
│       ├── _data_deny_IAMResource_Creation_Without_Valid_Tag_Keys.tf
│       ├── _data_deny_Leave_Organization.tf
│       ├── _data_deny_Marketplace_Subscribe.tf
│       ├── _data_deny_Reserved_Instances.tf
│       ├── _data_deny_Resource_creation_without_Valid_Tag_keys_Ec2.tf
│       ├── _data_deny_Resource_creation_without_Valid_Tag_keys_Ec2_Scheduler.tf
│       ├── _data_deny_Unauthorized_Wex_Regions.tf
│       ├── attach_policies_to_accounts.tf
│       ├── attach_policies_to_org_units.tf
│       ├── create_account_level_service_control_policies.tf
│       ├── create_ou_level_service_control_policies.tf
│       └── provider.tf
└── modules                               [Reusable modules]
    └── aws_organizations  
        ├── member_account                [Module to create Member Accounts]
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        ├── organizational_unit           [Module to create OU's]
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── service_control_policies      [Module to create Service Control Policies]
            ├── main.tf
            ├── outputs.tf
            └── variables.tf
