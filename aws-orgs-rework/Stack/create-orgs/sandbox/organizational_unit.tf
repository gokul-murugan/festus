module "create_ou" {
  source = "../../../Modules/aws_organizations/organizational_unit"

  parent_id                = "r-xdx0"
  organizational_unit_name = "Sandbox"
  ou_tags = {
    Owner = "Gokul"
  }
}
