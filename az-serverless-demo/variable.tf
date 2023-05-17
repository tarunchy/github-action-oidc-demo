variable "resource_group_name" {}
variable "resource_group_location" {}
variable "tags" {
  type = map(string)
}
variable "vnet_name" {}
variable "vnet_address_space" {
  type = list(string)
}
variable "subnet_names" {
  type = list(string)
}
variable "subnet_prefixes" {
  type = list(string)
}
variable "app_service_plan_name" {}
variable "app_service_plan_sku_name" {}
variable "app_service_always_on" {}
variable "frontwebapp_name" {}
variable "backwebapp_name" {}
variable "private_endpoint_name" {}
variable "dns_private_zone_name" {}
variable "private_dns_zone_link_name" {}
variable "app_tech_stack" {}
