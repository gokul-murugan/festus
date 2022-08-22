resource "aws_organizations_policy" "this" {
  for_each = var.service_control_policies

  name        = each.key
  description = each.value.description
  content     = each.value.policy_json
}