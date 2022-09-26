data "aws_iam_policy_document" "CloudtrailCloudwatchLogsRole" {
  statement {
    sid    = "CloudtrailCloudwatchLogsRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "CloudtrailCloudwatchLogsRole" {
  name               = "CloudtrailCloudwatchLogsRole"
  assume_role_policy = data.aws_iam_policy_document.CloudtrailCloudwatchLogsRole.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "cloudtrail_cloudwatch_logs_policy" {
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:*:229349022034:log-group:CloudTrail/DefaultLogGroup:log-stream:229349022034*"
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:229349022034:log-group:CloudTrail/DefaultLogGroup:log-stream:229349022034*",
    ]

  }
}

resource "aws_iam_policy" "cloudtrail_cloudwatch_logs_policy" {
  name   = "cloudtrail_cloudwatch_logs_policy"
  policy = data.aws_iam_policy_document.cloudtrail_cloudwatch_logs_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudtrail_cloudwatch_logs_policy_attach" {
  role       = aws_iam_role.CloudtrailCloudwatchLogsRole.name
  policy_arn = aws_iam_policy.cloudtrail_cloudwatch_logs_policy.arn
}