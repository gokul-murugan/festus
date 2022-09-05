# Creates an OU (Organizational Unit)

resource "aws_organizations_organizational_unit" "this" {
  name      = var.organizational_unit_name
  parent_id = var.parent_id
  tags      = var.ou_tags
}