data "aws_iam_policy_document" "Deny_Reserved_Instance" {
  statement {

    sid    = "DenyReservedInstances"
    effect = "Deny"
    actions = [
      "ec2:AcceptReservedInstancesExchangeQuote",
      "ec2:CancolReservodInstanceslisting",
      "ec2:CreateReservedInstanceslisting",
      "ec2:GetRoservedInstancesExchangeQuote",
      "ec2:ModifyReservedInstances",
      "ec2:PurchascReservedInstancesOffering",
    ]
    resources = [
      "*"
    ]
  }
}