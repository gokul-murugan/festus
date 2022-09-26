data "aws_iam_policy_document" "SAMLSystemAdministrator" {
  statement {
    sid    = "samlSystemAdministrator"
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

resource "aws_iam_role" "SAMLSystemAdministrator" {
  name               = "SAMLSystemAdministrator"
  assume_role_policy = data.aws_iam_policy_document.SAMLSystemAdministrator.json
}

resource "aws_iam_role_policy_attachment" "SAMLSystemAdministrator_ManagedPolicies" {
  count = length(local.SAMLSystemAdministratorRolePolicies)

  role       = aws_iam_role.SAMLSystemAdministrator.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLSystemAdministratorRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "iam_access" {
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
      "iam:ListInstanceProfiles*",
      "iam:ListEntitiesForPolicy"
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
}

resource "aws_iam_policy" "iam_access" {
  name   = "iam_access"
  policy = data.aws_iam_policy_document.iam_access.json
}

resource "aws_iam_role_policy_attachment" "iam_access_attach" {
  role       = aws_iam_role.SAMLSystemAdministrator.name
  policy_arn = aws_iam_policy.iam_access.arn
}

data "aws_iam_policy_document" "system_admin_kms_access" {
  statement {
    sid    = "kmsAccess"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "system_admin_kms_access" {
  name   = "kms_access"
  policy = data.aws_iam_policy_document.system_admin_kms_access.json
}

resource "aws_iam_role_policy_attachment" "system_admin_kms_access_attach" {
  role       = aws_iam_role.SAMLSystemAdministrator.name
  policy_arn = aws_iam_policy.system_admin_kms_access.arn
}

data "aws_iam_policy_document" "system_admin_vpc_restrict_policy" {
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

resource "aws_iam_policy" "system_admin_vpc_restrict_policy" {
  name   = "system_admin_vpc_restrict_policy"
  policy = data.aws_iam_policy_document.system_admin_vpc_restrict_policy.json
}

resource "aws_iam_role_policy_attachment" "system_admin_vpc_restrict_policy_attach" {
  role       = aws_iam_role.SAMLSystemAdministrator.name
  policy_arn = aws_iam_policy.system_admin_vpc_restrict_policy.arn
}
