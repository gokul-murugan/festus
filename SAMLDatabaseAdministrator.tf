data "aws_iam_policy_document" "SAMLDatabaseAdministrator" {
  statement {
    sid    = "samlSystemAdministrator"
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = ["arn:aws:iam::229349022034:saml-provider/Okta",
        "arn:aws:iam::229349022034:saml-provider/OktaDemo"
      ]
    }
    actions = [
      "sts:AssumeRoleWithSAML"
    ]
    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

resource "aws_iam_role" "SAMLDatabaseAdministrator" {
  name               = "SAMLDatabaseAdministrator"
  assume_role_policy = data.aws_iam_policy_document.SAMLDatabaseAdministrator.json
}

resource "aws_iam_role_policy_attachment" "SAMLDatabaseAdministrator_ManagedPolicies" {
  count = length(local.SAMLDatabaseAdministratorRolePolicies)

  role       = aws_iam_role.SAMLDatabaseAdministrator.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLDatabaseAdministratorRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "directory_service_read_access" {
  statement {
    sid    = "directoryServiceReadAccess"
    effect = "Allow"
    actions = [
      "ds:ListAuthorizedApplications",
      "ds:DescribeTrusts",
      "ds:ListSchemaExtensions",
      "ds:DescribeEventTopics",
      "ds:DescribeSnapshots",
      "ds:GetSnapshotLimits",
      "ds:DescribeConditionalForwarders",
      "ds:ListTagsForResource",
      "ds:DescribeDirectories",
      "ds:ListIpRoutes",
      "ds:GetDirectoryLimits"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "directory_service_read_access" {
  name   = "directory_service_read_access"
  policy = data.aws_iam_policy_document.directory_service_read_access.json
}

resource "aws_iam_role_policy_attachment" "directory_service_read_access_attach" {
  role       = aws_iam_role.SAMLDatabaseAdministrator.name
  policy_arn = aws_iam_policy.directory_service_read_access.arn
}

data "aws_iam_policy_document" "lbd_kms_cfn_dms_iam_ec2_sm_access" {
  statement {
    sid    = "ReadWriteFullAccess"
    effect = "Allow"
    actions = [
      "kms:*",
      "lambda:*",
      "cloudformation:*",
      "dms:*",
      "serverlessrepo:*",
      "secretsmanager:*"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "redshift:Describe*",
      "redshift:ModifyClusterIamRoles"
    ]
    resources = [
      "*",
    ]
    condition {
      test     = "ArnNotEquals"
      variable = "iam:PolicyArn"
      values = [
        "arn:aws:iam::aws:policy/AdministratorAccess",
        "arn:aws:iam::aws:policy/job-function/Billing",
        "arn:aws:iam::aws:policy/job-function/DatabaseAdministrator",
        "arn:aws:iam::aws:policy/job-function/DataScientist",
        "arn:aws:iam::aws:policy/job-function/NetworkAdministrator",
        "arn:aws:iam::aws:policy/PowerUserAccess",
        "arn:aws:iam::aws:policy/SecurityAudit",
        "arn:aws:iam::aws:policy/job-function/SupportUser",
        "arn:aws:iam::aws:policy/job-function/SystemAdministrator",
        "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
        "arn:aws:iam::aws:policy/aws-service-role/AWSOrganizationsServiceTrustPolicy",
        "arn:aws:iam::aws:policy/IAM*"
      ]
    }
  }
  statement {
    sid    = "LimitedAttachmentPermissions"
    effect = "Allow"
    actions = [
      "iam:DetachRolePolicy",
      "iam:AttachRolePolicy"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "RolesCreateAccess"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteInstanceProfile",
      "iam:UpdateAssumeRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:DeleteRole",
      "iam:UpdateRoleDescription",
      "iam:DeleteServiceLinkedRole",
      "iam:PutRolePolicy",
      "iam:CreateInstanceProfile",
      "iam:CreateServiceLinkedRole",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:ListPoliciesGrantingServiceAccess",
      "iam:ListAttached*",
      "iam:AddRoleToInstanceProfile",
      "iam:GetPolicy*",
      "iam:PassRole",
      "iam:GetServiceLastAccessed*",
      "iam:ListRolePolicies",
      "iam:GetRole*",
      "iam:ListPolicies",
      "iam:GetInstanceProfile",
      "iam:ListRoles",
      "iam:ListUserPolicies",
      "iam:Simulate*",
      "iam:ListPolicyVersions",
      "iam:GetAccount*",
      "iam:GetLoginProfile",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:ListInstanceProfiles*",
      "iam:ListEntitiesForPolicy",
      "iam:UntagPolicy",
      "iam:TagPolicy",
      "iam:UntagInstanceProfile",
      "iam:TagInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "ExplictDenyForSAMLRoles"
    effect = "Deny"
    actions = [
      "iam:*"
    ]
    resources = [
      "arn:aws:iam::229349022034:role/SAML*"
    ]
  }
  statement {
    sid    = "EC2ResourcesViewAccess"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribePlacementGroups",
      "ec2:DescribeHostReservationOfferings",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVolumeStatus",
      "ec2:DescribeSpotDatafeedSubscription",
      "ec2:DescribeVolumes",
      "ec2:DescribeFpgaImageAttribute",
      "ec2:DescribeExportTasks",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeNetworkInterfacePermissions",
      "ec2:DescribeReservedInstances",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeRouteTables",
      "ec2:DescribeReservedInstancesListings",
      "ec2:DescribeEgressOnlyInternetGateways",
      "ec2:DescribeSpotFleetRequestHistory",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeVpcClassicLinkDnsSupport",
      "ec2:DescribeSnapshotAttribute",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeIdFormat",
      "ec2:DescribeVpcEndpointServiceConfigurations",
      "ec2:DescribePrefixLists",
      "ec2:DescribeVolumeAttribute",
      "ec2:DescribeInstanceCreditSpecifications",
      "ec2:DescribeVpcClassicLink",
      "ec2:DescribeImportSnapshotTasks",
      "ec2:DescribeVpcEndpointServicePermissions",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeReservedInstancesModifications",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpnGateways",
      "ec2:DescribeMovingAddresses",
      "ec2:DescribeAddresses",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeRegions",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeVpcEndpointServices",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeVpcEndpointConnections",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeHostReservations",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeBundleTasks",
      "ec2:DescribeIdentityIdFormat",
      "ec2:DescribeImportImageTasks",
      "ec2:DescribeClassicLinkInstances",
      "ec2:DescribeNatGateways",
      "ec2:DescribeCustomerGateways",
      "ec2:DescribeVpcEndpointConnectionNotifications",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotFleetRequests",
      "ec2:DescribeHosts",
      "ec2:DescribeImages",
      "ec2:DescribeFpgaImages",
      "ec2:DescribeSpotFleetInstances",
      "ec2:DescribeSecurityGroupReferences",
      "ec2:DescribeVpcs",
      "ec2:DescribeConversionTasks",
      "ec2:DescribeStaleSecurityGroups"

    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "lbd_kms_cfn_dms_iam_ec2_sm_access" {
  name   = "lbd_kms_cfn_dms_iam_ec2_sm_access"
  policy = data.aws_iam_policy_document.lbd_kms_cfn_dms_iam_ec2_sm_access.json
}

resource "aws_iam_role_policy_attachment" "lbd_kms_cfn_dms_iam_ec2_sm_access_attach" {
  role       = aws_iam_role.SAMLDatabaseAdministrator.name
  policy_arn = aws_iam_policy.lbd_kms_cfn_dms_iam_ec2_sm_access.arn
}

data "aws_iam_policy_document" "route53_records_change_access" {
  statement {
    sid    = "route53RecordsChangeAccess"
    effect = "Allow"
    actions = [
      "route53:ListTrafficPolicyInstancesByHostedZone",
      "route53:ListTrafficPolicies",
      "route53:GetHostedZone",
      "route53:ListHostedZones",
      "route53:ChangeResourceRecordSets",
      "route53:ListVPCAssociationAuthorizations",
      "route53:ListResourceRecordSets",
      "route53:GetHostedZoneCount",
      "route53:ListHostedZonesByName",
      "route53:GetChangeRequest",
      "route53:GetChange"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "route53_records_change_access" {
  name   = "route53_records_change_access"
  policy = data.aws_iam_policy_document.route53_records_change_access.json
}

resource "aws_iam_role_policy_attachment" "route53_records_change_access_attach" {
  role       = aws_iam_role.SAMLDatabaseAdministrator.name
  policy_arn = aws_iam_policy.route53_records_change_access.arn
}

data "aws_iam_policy_document" "vpc_restrict_policy" {
  statement {
    sid    = "VpcTagsAccessDeny"
    effect = "Deny"
    actions = [
      "ec2:DeleteTags",
      "ec2:CreateTags",
      "ec2:DescribeTags"
    ]
    resources = [
      "arn:aws:ec2:*:229349022034:route-table/*",
      "arn:aws:ec2:*:229349022034:subnet/*",
      "arn:aws:ec2:*:229349022034:dhcp-options/*",
      "arn:aws:ec2:*:229349022034:network-acl/*",
      "arn:aws:ec2:*:229349022034:vpc-endpoint/*",
      "arn:aws:ec2:*:229349022034:transit-gateway-attachment/*",
      "arn:aws:ec2:*:229349022034:natgateway/*",
      "arn:aws:ec2:*:229349022034:vpc-peering-connection/*",
      "arn:aws:ec2:*:229349022034:internet-gateway/*",
      "arn:aws:ec2:*:229349022034:vpn-gateway/*",
      "arn:aws:ec2:*:229349022034:vpc-flow-log/*",
      "arn:aws:ec2:*:229349022034:local-gateway-route-table-virtual-interface-group-association/*",
      "arn:aws:ec2:*:229349022034:transit-gateway-route-table/*",
      "arn:aws:ec2:*:229349022034:local-gateway-route-table/*",
      "arn:aws:ec2:*:229349022034:vpc-endpoint-service/*",
      "arn:aws:ec2:*:229349022034:transit-gateway/*",
      "arn:aws:ec2:*:229349022034:vpc/*",
      "arn:aws:ec2:*:229349022034:customer-gateway/*",
      "arn:aws:ec2:*:229349022034:client-vpn-endpoint/*",
      "arn:aws:ec2:*:229349022034:vpn-connection/*",
      "arn:aws:ec2:*:229349022034:local-gateway-route-table-vpc-association/*",
      "arn:aws:ec2:*:229349022034:local-gateway/*"
    ]
  }
  statement {
    sid    = "VpcAccessDeny"
    effect = "Deny"
    actions = [
      "ec2:DeleteSubnet",
      "ec2:ModifyVpcEndpointServiceConfiguration",
      "ec2:DetachClassicLinkVpc",
      "ec2:DeleteClientVpnEndpoint",
      "ec2:DeleteVpcPeeringConnection",
      "ec2:DeleteVpcEndpoints",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:AcceptVpcPeeringConnection",
      "ec2:ModifyClientVpnEndpoint",
      "ec2:AcceptTransitGatewayVpcAttachment",
      "ec2:DisableVgwRoutePropagation",
      "ec2:AssociateVpcCidrBlock",
      "ec2:DeleteLocalGatewayRouteTableVpcAssociation",
      "ec2:ReplaceRoute",
      "ec2:AssociateRouteTable",
      "ec2:DeleteRouteTable",
      "ec2:RejectVpcPeeringConnection",
      "ec2:DisassociateVpcCidrBlock",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DeleteVpnGateway",
      "ec2:CreateRoute",
      "ec2:ModifyVpcPeeringConnectionOptions",
      "ec2:CreateVpnGateway",
      "ec2:AssociateTransitGatewayRouteTable",
      "ec2:RejectTransitGatewayVpcAttachment",
      "ec2:DeleteVpnConnection",
      "ec2:CreateVpcPeeringConnection",
      "ec2:RejectVpcEndpointConnections",
      "ec2:EnableVpcClassicLink",
      "ec2:DisassociateTransitGatewayRouteTable",
      "ec2:DisableTransitGatewayRouteTablePropagation",
      "ec2:CreateVpcEndpointConnectionNotification",
      "ec2:DeleteLocalGatewayRouteTablePermission",
      "ec2:CreateRouteTable",
      "ec2:CreateLocalGatewayRouteTableVpcAssociation",
      "ec2:DisassociateRouteTable",
      "ec2:ModifyVpcEndpointConnectionNotification",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:CreateVpcEndpointServiceConfiguration",
      "ec2:DetachVpnGateway",
      "ec2:CreateTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:CreateDefaultVpc",
      "ec2:DeleteLocalGatewayRoute",
      "ec2:AssociateSubnetCidrBlock",
      "ec2:DeleteVpc",
      "ec2:EnableTransitGatewayRouteTablePropagation",
      "ec2:CreateSubnet",
      "ec2:CreateLocalGatewayRouteTablePermission",
      "ec2:ModifyVpcEndpoint",
      "ec2:CreateVpnConnection",
      "ec2:MoveAddressToVpc",
      "ec2:ExportTransitGatewayRoutes",
      "ec2:CreateVpc",
      "ec2:ModifyVpnConnection",
      "ec2:CreateSubnetCidrReservation",
      "ec2:DeleteVpcEndpointServiceConfigurations",
      "ec2:ReplaceTransitGatewayRoute",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateDefaultSubnet",
      "ec2:ModifyVpcAttribute",
      "ec2:AttachClassicLinkVpc",
      "ec2:ModifyTransitGatewayVpcAttachment",
      "ec2:DisassociateClientVpnTargetNetwork",
      "ec2:CreateLocalGatewayRoute",
      "ec2:CreateClientVpnRoute",
      "ec2:AcceptVpcEndpointConnections",
      "ec2:AttachVpnGateway",
      "ec2:DeleteRoute",
      "ec2:CreateVpnConnectionRoute",
      "ec2:DisassociateSubnetCidrBlock",
      "ec2:CreateClientVpnEndpoint",
      "ec2:DeleteVpnConnectionRoute",
      "ec2:AuthorizeClientVpnIngress",
      "ec2:DeleteVpcEndpointConnectionNotifications",
      "ec2:ModifyVpcEndpointServicePayerResponsibility",
      "ec2:CreateVpcEndpoint",
      "ec2:DeleteClientVpnRoute",
      "ec2:StartVpcEndpointServicePrivateDnsVerification",
      "ec2:DisableVpcClassicLinkDnsSupport",
      "ec2:DisableVpcClassicLink",
      "ec2:ModifyVpcTenancy",
      "ec2:EnableVpcClassicLinkDnsSupport",
      "ec2:DeleteSubnetCidrReservation"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "vpc_restrict_policy" {
  name   = "vpc_restrict_policy"
  policy = data.aws_iam_policy_document.vpc_restrict_policy.json
}

resource "aws_iam_role_policy_attachment" "vpc_restrict_policy_attach" {
  role       = aws_iam_role.SAMLDatabaseAdministrator.name
  policy_arn = aws_iam_policy.vpc_restrict_policy.arn
}
