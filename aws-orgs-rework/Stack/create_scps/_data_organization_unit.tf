# data "aws_organizations_organization" "org" {
# }

# data "aws_organizations_organizational_units" "ou" {
#   parent_id = data.aws_organizations_organization.org.roots[0].id
# }

# output "orgs_unit" {
#   value = data.aws_organizations_organizational_units.ou
# }

# # Output Format ==> Its a normal List of Maps, so when we create a new orgs high chances the order will change leading to chaos

# children": [
#           {
#             "arn": "arn:aws:organizations::092874920405:ou/o-eozi2mqdwq/ou-xdx0-arjfeftd",
#             "id": "ou-xdx0-arjfeftd",
#             "name": "AWS-Develop-Monitoring"
#           },
#           {
#             "arn": "arn:aws:organizations::092874920405:ou/o-eozi2mqdwq/ou-xdx0-uwx4toon",
#             "id": "ou-xdx0-uwx4toon",
#             "name": "Sandbox"
#           },
#           {
#             "arn": "arn:aws:organizations::092874920405:ou/o-eozi2mqdwq/ou-xdx0-beng9pjp",
#             "id": "ou-xdx0-beng9pjp",
#             "name": "Security"
#           },
#           {
#             "arn": "arn:aws:organizations::092874920405:ou/o-eozi2mqdwq/ou-xdx0-3bgtf1ny",
#             "id": "ou-xdx0-3bgtf1ny",
#             "name": "Gokul Test"
#           }
#         ]