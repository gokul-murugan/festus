data "aws_iam_policy_document" "AxoniusMemberRole" {
  statement {
    sid    = "axoniusMemberRole"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::189106039250:role/wex-axonius-master-exec-role"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "AxoniusMemberRole" {
  name               = "AxoniusMemberRole"
  assume_role_policy = data.aws_iam_policy_document.AxoniusMemberRole.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "axonius_adapter_member_access_policy" {
  statement {
    sid    = "AxoniusFullLeastAccess"
    effect = "Allow"
    actions = [
      "apigateway:GET",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "cloudfront:GetDistribution",
      "cloudfront:ListDistributions",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetEventSelectors",
      "cloudtrail:GetTrailStatus",
      "cloudwatch:DescribeAlarmsForMetric",
      "config:DescribeConfigurationRecorders",
      "config:DescribeConfigurationRecorderStatus",
      "dynamodb:DescribeGlobalTable",
      "dynamodb:DescribeGlobalTableSettings",
      "dynamodb:DescribeTable",
      "dynamodb:ListGlobalTables",
      "dynamodb:ListTables",
      "ec2:DescribeAddresses",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcs",
      "ecs:DescribeClusters",
      "ecs:DescribeContainerInstances",
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:ListClusters",
      "ecs:ListContainerInstances",
      "ecs:ListServices",
      "ecs:ListTagsForResource",
      "ecs:ListTasks",
      "ecs:ListTasks",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerPolicies",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "es:DescribeElasticsearchDomain*",
      "es:ListDomainNames",
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:GetAccountSummary",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccessKeyLastUsed",
      "iam:GetCredentialReport",
      "iam:GetLoginProfile",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:ListEntitiesForPolicy",
      "iam:ListPolicies",
      "iam:ListAccessKeys",
      "iam:ListAccountAliases",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupsForUser",
      "iam:ListInstanceProfilesForRole",
      "iam:ListMFADevices",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "iam:ListUserPolicies",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "kms:GenerateDataKey",
      "kms:Decrypt",
      "kms:ListKeys",
      "lambda:GetPolicy",
      "lambda:ListFunctions",
      "logs:DescribeMetricFilters",
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization",
      "organizations:ListAccounts",
      "organizations:DescribeEffectivePolicy",
      "organizations:DescribePolicy",
      "organizations:ListPoliciesForTarget",
      "organizations:ListTagsForResource",
      "rds:DescribeDBInstances",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketTagging",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:ListAllMyBuckets",
      "s3:PutObject",
      "s3:PutObjectTagging",
      "servicediscovery:ListNamespaces",
      "sns:ListSubscriptionsByTopic",
      "ssm:DescribeAvailablePatches",
      "ssm:DescribeInstanceInformation",
      "ssm:DescribeInstancePatches",
      "ssm:DescribePatchGroups",
      "ssm:GetInventorySchema",
      "ssm:ListInventoryEntries",
      "ssm:ListResourceComplianceSummaries",
      "ssm:ListTagsForResource",
      "sts:GetCallerIdentity",
      "sts:AssumeRole",
      "waf:GetWebACL",
      "waf:ListWebACLs",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:ListWebACLs",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:ListWebACLs",
      "workspaces:DescribeTags",
      "workspaces:DescribeWorkspaceDirectories",
      "workspaces:DescribeWorkspaces",
      "workspaces:DescribeWorkspacesConnectionStatus"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "axonius_adapter_member_access_policy" {
  name   = "axonius_adapter_member_access_policy"
  policy = data.aws_iam_policy_document.axonius_adapter_member_access_policy.json
}

resource "aws_iam_role_policy_attachment" "axonius_adapter_member_access_policy_attach" {
  role       = aws_iam_role.AxoniusMemberRole.name
  policy_arn = aws_iam_policy.axonius_adapter_member_access_policy.arn
}