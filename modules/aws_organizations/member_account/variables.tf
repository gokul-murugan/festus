variable "account_name" {
  description = "Friendly name of the Member account"
  type        = string
}

variable "account_owner_email" {
  description = "Email address of the account owner"
  type        = string
}

variable "organizational_unit_id" {
  description = "Organization unit ID where the account should be associated"
  type        = string
}

variable "account_tags" {
  description = "Resource tags for Member account"
  type = map(string)
}