output "policy_ids" {
  value = aws_organizations_policy.this[*]
}