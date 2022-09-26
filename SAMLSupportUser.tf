data "aws_iam_policy_document" "SAMLSupportUser" {
  statement {
    sid    = "samlSupportUser"
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

resource "aws_iam_role" "SAMLSupportUser" {
  name               = "SAMLSupportUser"
  assume_role_policy = data.aws_iam_policy_document.SAMLSupportUser.json
}

resource "aws_iam_role_policy_attachment" "SAMLSupportUser_ManagedPolicies" {
  count = length(local.SAMLSupportUserRolePolicies)

  role       = aws_iam_role.SAMLSupportUser.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.SAMLSupportUserRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "artifact_access" {
  statement {
    sid    = "artifactAccess"
    effect = "Allow"
    actions = [
      "artifact:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "artifact_access" {
  name   = "artifact_access"
  policy = data.aws_iam_policy_document.artifact_access.json
}

resource "aws_iam_role_policy_attachment" "artifact_access_attach" {
  role       = aws_iam_role.SAMLSupportUser.name
  policy_arn = aws_iam_policy.artifact_access.arn
}

data "aws_iam_policy_document" "read_access" {
  statement {
    sid    = "readAccess"
    effect = "Allow"
    actions = [
      "dynamodb:PartiQLSelect"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "read_access" {
  name   = "read_access"
  policy = data.aws_iam_policy_document.read_access.json
}

resource "aws_iam_role_policy_attachment" "read_access_attach" {
  role       = aws_iam_role.SAMLSupportUser.name
  policy_arn = aws_iam_policy.read_access.arn
}