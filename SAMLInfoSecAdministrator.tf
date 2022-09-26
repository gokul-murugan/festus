data "aws_iam_policy_document" "SAMLInfoSecAdministrator" {
  statement {
    sid    = "samlInfoSecAdministrator"
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

resource "aws_iam_role" "SAMLInfoSecAdministrator" {
  name               = "SAMLInfoSecAdministrator"
  assume_role_policy = data.aws_iam_policy_document.SAMLInfoSecAdministrator.json
}

resource "aws_iam_role_policy_attachment" "SAMLInfoSecAdministrator_ManagedPolicies" {
  count = length(local.SAMLInfoSecAdministratorRolePolicies)

  role       = aws_iam_role.SAMLInfoSecAdministrator.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLInfoSecAdministratorRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "custom_access" {
  statement {
    sid    = "customAccess"
    effect = "Allow"
    actions = [
      "ram:GetResourceShareAssociations",
      "access-analyzer:ListPolicyGenerations",
      "eks:AccessKubernetesApi"
    ]
    resources = [
      "arn:aws:ram:us-east-1:*:resource-share/*",
    ]
  }
}

resource "aws_iam_policy" "custom_access" {
  name   = "custom_access"
  policy = data.aws_iam_policy_document.custom_access.json
}

resource "aws_iam_role_policy_attachment" "custom_access_attach" {
  role       = aws_iam_role.SAMLInfoSecAdministrator.name
  policy_arn = aws_iam_policy.custom_access.arn
}