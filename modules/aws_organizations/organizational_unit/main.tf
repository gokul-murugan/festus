# Creates an OU (Organizational Unit)

resource "aws_organizations_organizational_unit" "this" {
  name      = var.organizational_unit_name
  parent_id = var.parent_id
  tags      = var.ou_tags
}

resource "aws_organizations_policy_attachment" "this" {
  for_each = var.service_control_policies_ids

  policy_id = each.value.policy_id
  target_id = aws_organizations_organizational_unit.this.id
}