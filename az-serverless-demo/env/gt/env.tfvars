resource_group_name     = "rg-its-sls-dev-wu-1"
resource_group_location = "westus"
tags = {
  "cost_center" = "1234H"
  "PHI"         = "True"
}
vnet_address_space = ["10.0.0.0/27"]
subnet_prefixes    = ["10.0.0.0/29", "10.0.0.8/29", "10.0.0.16/29", "10.0.0.24/29"]
vnet_name          = "vnet-its-sls-dev-wu-1"
subnet_names       = ["snet-its-sls-dev-wu-1", "snet-its-sls-dev-wu-2", "snet-its-sls-dev-wu-3", "snet-its-sls-dev-wu-4"]

# App Service Configs
app_service_plan_name     = "its-sls-dev-wu-asp-1"
app_service_name          = "its-sls-dev-wu-as-1"
app_service_plan_sku_name = "P1v2"
linux_fx_version          = "PYTHON|3.9"
app_service_always_on     = true

frontwebapp_name           = "cs-hack-front-dev"
backwebapp_name            = "cs-hack-back-dev"
private_endpoint_name      = "cs-hack-private-endpoint-dev"
dns_private_zone_name      = "privatelink.azurewebsites.net"
private_dns_zone_link_name = "cs-hack-dns-zone-link-dev"

