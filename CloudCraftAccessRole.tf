data "aws_iam_policy_document" "CloudCraftAccessRole" {
  statement {
    sid    = "CloudCraftAccessRole"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::968898580625:root"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["a7e5bf55-acb5-4b83-895f-c806c4d28b95"]
    }
  }
}

resource "aws_iam_role" "CloudCraftAccessRole" {
  name               = "CloudCraftAccessRole"
  assume_role_policy = data.aws_iam_policy_document.CloudCraftAccessRole.json
}

resource "aws_iam_role_policy_attachment" "CloudCraftAccessRole_ManagedPolicies" {
  count = length(local.CloudCraftAccessRolePolicies)

  role       = aws_iam_role.CloudCraftAccessRole.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.CloudCraftAccessRolePolicies[count.index])
}