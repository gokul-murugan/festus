data "aws_iam_policy_document" "Deny_Restrict_Resource_creation_without_Valid_Tag_keys_Ec2_Scheduler" {
  statement {
   
    sid    = "DenyRestrictResourceCreationWithoutValidTagKeysEc2Scheduler"
    effect = "Deny"
    actions = [
      "ec2:RunInstances"
    ]
    resources = [
      "arn:aws:ec2:*:instance/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:TagKeys"
      values = [
        "EC2ON",
        "EC2OFF",
        "aws:autoscaling:groupName",
        "NOSCHEDULE"
      ]
    }
  }
  statement {
    effect = "Deny"
    actions = [
      "autoscaling:CreateAutoScalingGroup"
    ]
    resources = [
      "arn:aws:autoscaling:*:*:autoScalingGroup:*:autoScalingGroupName/*"
    ]
    condition {
      test     = "ForAllValues:StringNotEquals"
      variable = "aws:TagKeys"
      values = [
        "ASGON",
        "ASGOFF",
        "NOSCHEDULE"
      ]
    }
  }

}

