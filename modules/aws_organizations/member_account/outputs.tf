output "account_id" {
  description = "ID of the member account"
  value       = aws_organizations_account.this.id
}