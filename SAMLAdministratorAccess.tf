data "aws_iam_policy_document" "SAMLAdministratorAccess" {
  statement {
    sid    = "samlSystemAdministrator"
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::229349022034:saml-provider/Okta",
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

resource "aws_iam_role" "SAMLAdministratorAccess" {
  name               = "SAMLAdministratorAccess"
  assume_role_policy = data.aws_iam_policy_document.SAMLAdministratorAccess.json
}

resource "aws_iam_role_policy_attachment" "SAMLAdministratorAccess_ManagedPolicies" {
  count = length(local.SAMLAdministratorAccessRolePolicies)

  role       = aws_iam_role.SAMLAdministratorAccess.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLAdministratorAccessRolePolicies[count.index])
}