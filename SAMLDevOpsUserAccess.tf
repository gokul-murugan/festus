data "aws_iam_policy_document" "SAMLDevOpsUserAccess" {
  statement {
    sid    = "samlDevOpsUserAccess"
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::229349022034:saml-provider/Okta"
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

resource "aws_iam_role" "SAMLDevOpsUserAccess" {
  name               = "SAMLDevOpsUserAccess"
  assume_role_policy = data.aws_iam_policy_document.SAMLDevOpsUserAccess.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "devops_user_kms_access" {
  statement {
    sid    = "KmsAccess"
    effect = "Allow"
    actions = [
      "lkms:*"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "devops_user_kms_access" {
  name   = "devops_user_kms_access"
  policy = data.aws_iam_policy_document.devops_user_kms_access.json
}

resource "aws_iam_role_policy_attachment" "devops_user_kms_access_attach" {
  role       = aws_iam_role.SAMLDevOpsUserAccess.name
  policy_arn = aws_iam_policy.devops_user_kms_access.arn
}

data "aws_iam_policy_document" "power_user_with_role_create_access_policy" {
  statement {
    sid    = "powerUserWithRoleCreateAccessPolicy"
    effect = "Allow"
    not_actions = [
      "iam:*",
      "organizations:*"
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
      "*",
    ]
  }
  statement {
    sid    = "RolesAndPolicyCreateAccess"
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
      "iam:List*",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:AddRoleToInstanceProfile",
      "iam:GetPolicy*",
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion",
      "iam:PassRole",
      "iam:GetServiceLastAccessed*",
      "iam:GetRole*",
      "iam:GetInstanceProfile",
      "iam:Simulate*",
      "iam:GetAccount*",
      "iam:UntagPolicy",
      "iam:TagPolicy",
      "iam:UntagInstanceProfile",
      "iam:TagInstanceProfile"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "DirectoryAndQuickSightAccess"
    effect = "Allow"
    actions = [
      "ds:AuthorizeApplication",
      "ds:CheckAlias",
      "ds:CreateAlias",
      "ds:CreateIdentityPoolDirectory",
      "ds:DeleteDirectory",
      "ds:DescribeDirectories",
      "ds:DescribeTrusts",
      "ds:UnauthorizeApplication",
      "quicksight:CreateUser",
      "quicksight:CreateAdmin",
      "quicksight:Subscribe",
      "quicksight:GetGroupMapping",
      "quicksight:SearchDirectoryGroups",
      "quicksight:SetGroupMapping",
      "quicksight:Unsubscribe"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "ExplictDenyForSAMLRoles"
    effect = "Deny"
    actions = [
      "iam:*"
    ]
    resources = [
      "arn:aws:iam::229349022034:role/SAML*",
    ]
  }
  statement {
    sid    = "IdentityProvidersAccess"
    effect = "Allow"
    actions = [
      "iam:RemoveClientIDFromOpenIDConnectProvider",
      "iam:UpdateOpenIDConnectProviderThumbprint",
      "iam:UntagOpenIDConnectProvider",
      "iam:AddClientIDToOpenIDConnectProvider",
      "iam:DeleteOpenIDConnectProvider",
      "iam:GetOpenIDConnectProvider",
      "iam:TagOpenIDConnectProvider",
      "iam:CreateOpenIDConnectProvider"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "power_user_with_role_create_access_policy" {
  name   = "power_user_with_role_create_access_policy"
  policy = data.aws_iam_policy_document.power_user_with_role_create_access_policy.json
}

resource "aws_iam_role_policy_attachment" "power_user_with_role_create_access_policy_attach" {
  role       = aws_iam_role.SAMLDevOpsUserAccess.name
  policy_arn = aws_iam_policy.power_user_with_role_create_access_policy.arn
}

data "aws_iam_policy_document" "devops_user_vpc_restrict_policy" {
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
      "*",
    ]

  }
}

resource "aws_iam_policy" "Devops_user_Vpc_restrict_policy" {
  name   = "Vpc-restrict-policy"
  policy = data.aws_iam_policy_document.devops_user_vpc_restrict_policy.json
}

resource "aws_iam_role_policy_attachment" "Devops_user_Vpc_restrict_policy_attach" {
  role       = aws_iam_role.SAMLDevOpsUserAccess.name
  policy_arn = aws_iam_policy.Devops_user_Vpc_restrict_policy.arn
}
