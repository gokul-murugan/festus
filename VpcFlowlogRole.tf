data "aws_iam_policy_document" "VpcFlowlogRole" {
  statement {
    sid    = "vpcFlowlogRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "VpcFlowlogRole" {
  name               = "VpcFlowlogRole"
  assume_role_policy = data.aws_iam_policy_document.VpcFlowlogRole.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "vpc_flowlogs_write_access_policy" {
  statement {
    sid    = "vpcFlowlogsWriteAccessPolicy"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "vpc_flowlogs_write_access_policy" {
  name   = "vpc_flowlogs_write_access_policy"
  policy = data.aws_iam_policy_document.vpc_flowlogs_write_access_policy.json
}

resource "aws_iam_role_policy_attachment" "vpc_flowlogs_write_access_policy_attach" {
  role       = aws_iam_role.VpcFlowlogRole.name
  policy_arn = aws_iam_policy.vpc_flowlogs_write_access_policy.arn
}