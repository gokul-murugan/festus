data "aws_iam_policy_document" "LambdaAutoTagRole" {
  statement {
    sid    = "lambdaAutoTagRole"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "LambdaAutoTagRole" {
  name               = "LambdaAutoTagRole"
  assume_role_policy = data.aws_iam_policy_document.LambdaAutoTagRole.json
}

# All Customer Managed Policies

data "aws_iam_policy_document" "Lambda_resource_tagging_access" {
  statement {
    sid    = "lambdaResourceTagAccess"
    effect = "Allow"
    actions = [
      "cloudtrail:LookupEvents"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "lambdaResourceTaggingAccess"
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
      "ec2:Describe*",
      "tag:tagResources",
      "rds:AddTagsToResource",
      "elasticloadbalancing:AddTags",
      "s3:PutBucketTagging",
      "glacier:AddTagsToVault",
      "autoscaling:CreateOrUpdateTags",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "tag:GetResources"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "Lambda_resource_tagging_access" {
  name   = "Lambda_resource_tagging_access"
  policy = data.aws_iam_policy_document.Lambda_resource_tagging_access.json
}

resource "aws_iam_role_policy_attachment" "Lambda_resource_tagging_access_attach" {
  role       = aws_iam_role.LambdaAutoTagRole.name
  policy_arn = aws_iam_policy.Lambda_resource_tagging_access.arn
}