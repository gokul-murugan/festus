data "aws_iam_policy_document" "Deny_Restrict_Resource_creation_without_Valid_Tag_keys_Ec2" {
  statement {

    sid    = "DenyRestrictResourceCreationWithoutValidTagkeysEc2"
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume",
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/",
      "arn:aws:ec2:*:*:volume/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:TagKeys"
      values   = ["billingid"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CopySnapshot"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:TagKeys"
      values   = ["billingid"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateImage"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*",
      "arn:aws:ec2:*::image/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["billingid"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume"
    ]
    resources = [
      "arn:aws:ec2:*::instance/*",
      "arn:aws:ec2:*::volume/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["Name"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CopySnapshot"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*",
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["Name"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateImage"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*",
      "arn:aws:ec2:*::image/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["Name"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn: aws:ec2:*:*:volume/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["owner"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CopySnapshot"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["owner"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateImage"
    ]
    resources = [
      "arn:aws:ec2:*:*:snapshot/*",
      "arn:aws:ec2:*:*:image/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["owner"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:RunInstances",
      "ec2:CreateVolume"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ec2:*:*:volume/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["approle"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateSnapshot",
      "ec2:CopySnapshot"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["approle"]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "ec2:CreateImage"
    ]
    resources = [
      "arn:aws:ec2:*::snapshot/*",
      "arn:aws:ec2:*::image/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:Tagkeys"
      values   = ["approle"]
    }
  }
}