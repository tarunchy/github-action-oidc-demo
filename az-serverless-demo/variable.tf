variable "resource_group_name" {
  description = "Alphanumerics, underscores, parentheses, hyphens, periods, and unicode characters that match the regex documentation."
}

variable "resource_group_location" {
  description = "Location of the resource group."
}

variable "tags" {
  description = "Tags to be applied to the resources."
  type        = map(string)
}

variable "vnet_address_space" {
  description = "The address space that is used by the virtual network."
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
}

variable "vnet_name" {
  description = "The name of the virtual network."
}

variable "subnet_names" {
  description = "A list of names for each subnet."
  type        = list(string)
}

