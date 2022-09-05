data "aws_iam_policy_document" "deny_leave_orgs" {
  statement {
    sid    = "LeaveOrgsDeny"
    effect = "Deny"
    actions = [
      "organizations:LeaveOrganization"
    ]
    resources = [
      "*"
    ]
  }
}
