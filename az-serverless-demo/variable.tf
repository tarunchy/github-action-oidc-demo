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



variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
}

variable "app_service_plan_sku_name" {
  description = "The tier of the App Service Plan's SKU."
}

variable "linux_fx_version" {
  description = "The runtime stack used for your Linux App Service."
  type        = string
}

variable "app_service_always_on" {
  description = "Specifies whether the app service is always on."
  type        = bool
}

variable "frontwebapp_name" {
  description = "The name of the Frontend Web App."
}

variable "backwebapp_name" {
  description = "The name of the Backend Web App."
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint."
}

variable "dns_private_zone_name" {
  description = "The name of the DNS private zone."
}

variable "private_dns_zone_link_name" {
  description = "The name of the DNS zone link."
}



