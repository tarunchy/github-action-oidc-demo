variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "resource_group_location" {
  description = "The location of the resource group."
}

variable "tags" {
  description = "Tags to be applied to the resources."
  type        = map(string)
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
}

variable "app_service_name" {
  description = "The name of the App Service."
}

variable "vnet_name" {
  description = "The name of the VNet."
}

variable "subnet_name" {
  description = "The name of the subnet."
}

variable "app_service_plan_kind" {
  description = "The kind of the App Service Plan."
}

variable "app_service_plan_reserved" {
  description = "Specifies if the App Service Plan is reserved."
  type        = bool
}

variable "app_service_plan_sku_tier" {
  description = "The tier of the App Service Plan's SKU."
}

variable "app_service_plan_sku_size" {
  description = "The size of the App Service Plan's SKU."
}

variable "linux_fx_version" {
  description = "The runtime stack used for your Linux App Service."
  type        = string
}

variable "app_service_always_on" {
  description = "Specifies whether the app service is always on."
  type        = bool
}
