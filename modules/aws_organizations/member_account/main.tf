# Creates an Member account in the specified OU

resource "aws_organizations_account" "this" {
  name      = var.account_name
  email     = var.account_owner_email
  parent_id = var.organizational_unit_id
  tags      = var.account_tags
}