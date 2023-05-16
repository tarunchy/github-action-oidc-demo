variable "resource_group_name" {
  description   = "Alphanumerics, underscores, parentheses, hyphens, periods, and unicode characters that match the regex documentation."
}

variable "resource_group_location" {
  default = "westus"
  description   = "Location of the resource group."
}

variable "tags" {
  description = "Tags to be applied to the resources."
  type        = map(string)
}
