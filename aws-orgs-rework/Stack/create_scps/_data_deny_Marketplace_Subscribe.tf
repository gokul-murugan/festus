data "aws_iam_policy_document" "Restrict_Marketplace_purchases_deny" {
  statement {

    sid    = "MarketplaceSubscribedeny"
    effect = "Deny"
    actions = [
      "aws-marketplace:Subscribe"
    ]
    resources = [
      "*"
    ]
  }
}