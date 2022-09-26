data "aws_iam_policy_document" "AWSBackupServiceRole" {
  statement {
    sid    = "awsBackupServiceRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "backup.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "AWSBackupServiceRole" {
  name               = "AWSBackupServiceRole"
  assume_role_policy = data.aws_iam_policy_document.AWSBackupServiceRole.json
}

resource "aws_iam_role_policy_attachment" "AWSBackupServiceRole_ManagedPolicies" {
  count = length(local.AWSBackupServiceRolePolicies)

  role       = aws_iam_role.AWSBackupServiceRole.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.AWSBackupServiceRolePolicies[count.index])
}