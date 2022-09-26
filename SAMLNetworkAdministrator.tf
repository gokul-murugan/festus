data "aws_iam_policy_document" "SAMLNetworkAdministrator" {
  statement {
    sid    = "samlNetworkAdministrator"
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

resource "aws_iam_role" "SAMLNetworkAdministrator" {
  name               = "SAMLNetworkAdministrator"
  assume_role_policy = data.aws_iam_policy_document.SAMLNetworkAdministrator.json
}

resource "aws_iam_role_policy_attachment" "SAMLNetworkAdministrator_ManagedPolicies" {
  count = length(local.SAMLNetworkAdministratorRolePolicies)

  role       = aws_iam_role.SAMLNetworkAdministrator.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLNetworkAdministratorRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "trusted_advisor_access" {
  statement {
    sid    = "TrustedAdvisorAccess"
    effect = "Allow"
    actions = [
      "trustedadvisor:*"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "trusted_advisor_access" {
  name   = "trusted_advisor_access"
  policy = data.aws_iam_policy_document.trusted_advisor_access.json
}

resource "aws_iam_role_policy_attachment" "trusted_advisor_access_attach" {
  role       = aws_iam_role.SAMLNetworkAdministrator.name
  policy_arn = aws_iam_policy.trusted_advisor_access.arn
}

data "aws_iam_policy_document" "vpc_network_access" {
  statement {
    sid    = "VpcFirewallAccess"
    effect = "Allow"
    actions = [
      "network-firewall:*"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "PrefixAccess"
    effect = "Allow"
    actions = ["ec2:GetVpnConnectionDeviceSampleConfiguration",
      "ec2:GetVpnConnectionDeviceTypes",
      "ec2:DeleteManagedPrefixList",
      "ec2:ModifyManagedPrefixList",
      "ec2:DeleteClientVpnEndpoint",
      "ec2:CreateTransitGatewayConnect",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:ExportClientVpnClientConfiguration",
      "ec2:ModifyTransitGateway",
      "ec2:ModifyClientVpnEndpoint",
      "ec2:DescribeClientVpnConnections",
      "ec2:CreateTransitGatewayConnectPeer",
      "ec2:AcceptTransitGatewayVpcAttachment",
      "ec2:CreateTransitGateway",
      "ec2:CreateTransitGatewayPrefixListReference",
      "ec2:SearchTransitGatewayRoutes",
      "ec2:ModifyVpnConnectionOptions",
      "ec2:CreateTransitGatewayPeeringAttachment",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DeleteVpnGateway",
      "ec2:CreateTransitGatewayMulticastDomain",
      "ec2:CreateVpnGateway",
      "ec2:AssociateTransitGatewayRouteTable",
      "ec2:DescribeTransitGatewayMulticastDomains",
      "ec2:DescribeManagedPrefixLists",
      "ec2:RejectTransitGatewayVpcAttachment",
      "ec2:DeleteVpnConnection",
      "ec2:DescribeClientVpnEndpoints",
      "ec2:DisassociateTransitGatewayRouteTable",
      "ec2:DisableTransitGatewayRouteTablePropagation",
      "ec2:DeleteTransitGatewayPeeringAttachment",
      "ec2:GetManagedPrefixListEntries",
      "ec2:DescribeClientVpnRoutes",
      "ec2:DeregisterTransitGatewayMulticastGroupMembers",
      "ec2:CreateTags",
      "ec2:DescribeVpnConnections",
      "ec2:GetTransitGatewayAttachmentPropagations",
      "ec2:DescribeClientVpnTargetNetworks",
      "ec2:AssociateClientVpnTargetNetwork",
      "ec2:DescribePrefixLists",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:DetachVpnGateway",
      "ec2:CreateTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:GetTransitGatewayRouteTablePropagations",
      "ec2:EnableTransitGatewayRouteTablePropagation",
      "ec2:DeleteTransitGateway",
      "ec2:DescribeVpnGateways",
      "ec2:CreateVpnConnection",
      "ec2:DescribeTransitGatewayPeeringAttachments",
      "ec2:ExportTransitGatewayRoutes",
      "ec2:DeleteTags",
      "ec2:AcceptTransitGatewayPeeringAttachment",
      "ec2:ModifyVpnConnection",
      "ec2:DescribeTransitGateways",
      "ec2:ReplaceTransitGatewayRoute",
      "ec2:DeleteTransitGatewayMulticastDomain",
      "ec2:ExportClientVpnClientCertificateRevocationList",
      "ec2:RejectTransitGatewayPeeringAttachment",
      "ec2:RegisterTransitGatewayMulticastGroupSources",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:TerminateClientVpnConnections",
      "ec2:DeregisterTransitGatewayMulticastGroupSources",
      "ec2:ModifyVpnTunnelCertificate",
      "ec2:SearchTransitGatewayMulticastGroups",
      "ec2:GetTransitGatewayRouteTableAssociations",
      "ec2:DeleteTransitGatewayConnectPeer",
      "ec2:ModifyTransitGatewayVpcAttachment",
      "network-firewall:*",
      "ec2:DisassociateTransitGatewayMulticastDomain",
      "ec2:DisassociateClientVpnTargetNetwork",
      "ec2:CreateClientVpnRoute",
      "ec2:AttachVpnGateway",
      "ec2:DescribeTags",
      "ec2:RestoreManagedPrefixListVersion",
      "ec2:AssociateTransitGatewayMulticastDomain",
      "ec2:CreateVpnConnectionRoute",
      "ec2:RevokeClientVpnIngress",
      "ec2:RegisterTransitGatewayMulticastGroupMembers",
      "ec2:CreateManagedPrefixList",
      "ec2:CreateClientVpnEndpoint",
      "ec2:DeleteVpnConnectionRoute",
      "ec2:AuthorizeClientVpnIngress",
      "ec2:ModifyVpnTunnelOptions",
      "ec2:ImportClientVpnClientCertificateRevocationList",
      "ec2:DeleteClientVpnRoute",
      "ec2:DescribeClientVpnAuthorizationRules",
      "ec2:GetManagedPrefixListAssociations",
      "ec2:DeleteTransitGatewayConnect",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:ApplySecurityGroupsToClientVpnTargetNetwork",
      "ec2:GetTransitGatewayMulticastDomainAssociations"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "vpc_network_access" {
  name   = "vpc_network_access"
  policy = data.aws_iam_policy_document.vpc_network_access.json
}

resource "aws_iam_role_policy_attachment" "vpc_network_access_attach" {
  role       = aws_iam_role.SAMLNetworkAdministrator.name
  policy_arn = aws_iam_policy.vpc_network_access.arn
}