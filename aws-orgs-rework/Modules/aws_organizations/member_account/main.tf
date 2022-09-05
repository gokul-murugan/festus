# Creates Member accounts in the given OU

resource "aws_organizations_account" "this" {
  for_each = var.member_accounts

  name      = each.key
  email     = each.value.account_owner_email
  parent_id = each.value.organizational_unit_id
  tags      = each.value.account_tags
}