data "aws_iam_policy_document" "CustodianAgentAccess" {
  statement {
    sid    = "CustodianAgentAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::189106039250:user/cs-custodian-ado-pipeline-189106039250-sa-user",
        "arn:aws:iam::189106039250:role/ec2-sts-role"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "CustodianAgentAccess" {
  name               = "CustodianAgentAccess"
  assume_role_policy = data.aws_iam_policy_document.CustodianAgentAccess.json
}

resource "aws_iam_role_policy_attachment" "CustodianAgentAccess_ManagedPolicies" {
  count = length(local.CustodianAgentAccessRolePolicies)

  role       = aws_iam_role.CustodianAgentAccess.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.CustodianAgentAccessRolePolicies[count.index])
}