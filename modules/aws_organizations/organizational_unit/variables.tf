variable "organizational_unit_name" {
  description = "Name of the Organizational Unit (OU)"
  type        = string
}

variable "parent_id" {
  description = "ID of the Parent Organizational Unit (root)"
  type        = string
}

variable "ou_tags" {
  description = "Resource tags for the Organizational Unit (OU)"
  type        = map(string)
  default     = {}
}

variable "service_control_policies_ids" {
  description = "IDs of SCps that needs to attached to Organizational Unit (OU)"
  type        = any
}