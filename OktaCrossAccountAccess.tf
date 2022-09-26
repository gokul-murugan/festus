data "aws_iam_policy_document" "OktaCrossAccountAccess" {
  statement {
    sid    = "oktaLdpCrossAccountRole"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::069778080576:user/okta-admin-user"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "OktaCrossAccountAccess" {
  name               = "OktaCrossAccountAccess"
  assume_role_policy = data.aws_iam_policy_document.OktaCrossAccountAccess.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "okta_list_role_access" {
  statement {
    sid    = "oktaListRoleAccess"
    effect = "Allow"
    actions = [
      "iam:ListRoles",
      "iam:ListAccountAliases"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "okta_list_role_access" {
  name   = "okta_list_role_access"
  policy = data.aws_iam_policy_document.okta_list_role_access.json
}

resource "aws_iam_role_policy_attachment" "okta_list_role_access_attach" {
  role       = aws_iam_role.OktaCrossAccountAccess.name
  policy_arn = aws_iam_policy.okta_list_role_access.arn
}