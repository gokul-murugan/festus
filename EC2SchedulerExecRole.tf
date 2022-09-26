data "aws_iam_policy_document" "EC2SchedulerExecRole" {
  statement {
    sid    = "EC2SchedulerExecRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "ec2.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "EC2SchedulerExecRole" {
  name               = "EC2SchedulerExecRole"
  assume_role_policy = data.aws_iam_policy_document.EC2SchedulerExecRole.json
}

resource "aws_iam_role_policy_attachment" "EC2SchedulerExecRole_ManagedPolicies" {
  count = length(local.Ec2SchedulerExecRolePolicies)

  role       = aws_iam_role.EC2SchedulerExecRole.name
  policy_arn = format("%s/%s", "arn:aws:iam::aws:policy", local.Ec2SchedulerExecRolePolicies[count.index])
}

# All Customer Managed Policies

data "aws_iam_policy_document" "Ec2scheduler_access_policy" {
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "autoscaling:DeleteTags",
      "autoscaling:DescribeAutoScalingInstances",
      "ec2:DescribeInstances",
      "ec2:DeleteTags",
      "autoscaling:ResumeProcesses",
      "ec2:DescribeTags",
      "ec2:CreateTags",
      "autoscaling:DescribeTags",
      "autoscaling:SuspendProcesses",
      "ec2:StopInstances",
      "kms:ListKeys",
      "sts:AssumeRole",
      "ec2:StartInstances",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:CreateOrUpdateTags",
      "kms:ListAliases",
      "ec2:DescribeInstanceStatus",
      "iam:ListAccountAliases"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "Ec2SchedulerAccessPolicy"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "kms:ListGrants"
    ]
    resources = [
      "arn:aws:kms:*:229349022034:key/*ebs*",
    ]
  }
}

resource "aws_iam_policy" "Ec2scheduler_access_policy" {
  name   = "Ec2scheduler_access_policy"
  policy = data.aws_iam_policy_document.Ec2scheduler_access_policy.json
}

resource "aws_iam_role_policy_attachment" "Ec2scheduler_access_policy_attach" {
  role       = aws_iam_role.EC2SchedulerExecRole.name
  policy_arn = aws_iam_policy.Ec2scheduler_access_policy.arn
}

data "aws_iam_policy_document" "Lambda_BasicExec_Access_Policy" {
  statement {
    sid    = "LambdaBasicExecAccessPolicy"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "Lambda_BasicExec_Access_Policy" {
  name   = "Lambda_BasicExec_Access_Policy"
  policy = data.aws_iam_policy_document.Lambda_BasicExec_Access_Policy.json
}

resource "aws_iam_role_policy_attachment" "Lambda_BasicExec_Access_Policy_attach" {
  role       = aws_iam_role.EC2SchedulerExecRole.name
  policy_arn = aws_iam_policy.Lambda_BasicExec_Access_Policy.arn
}

data "aws_iam_policy_document" "SES_Access_Policy" {
  statement {
    sid    = "SESAccessPolicy"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::189106039250:role/WEXLambdaEc2MailerAccessRole",
    ]
  }
}

resource "aws_iam_policy" "SES_Access_Policy" {
  name   = "SES_Access_Policy"
  policy = data.aws_iam_policy_document.SES_Access_Policy.json
}

resource "aws_iam_role_policy_attachment" "SES_Access_Policy_attach" {
  role       = aws_iam_role.EC2SchedulerExecRole.name
  policy_arn = aws_iam_policy.SES_Access_Policy.arn
}