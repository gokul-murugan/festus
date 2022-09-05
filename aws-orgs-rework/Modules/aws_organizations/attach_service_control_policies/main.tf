resource "aws_organizations_policy_attachment" "this" {
  for_each = var.attach_policies

  policy_id = each.value.policy_id
  target_id = each.value.target_id
}
