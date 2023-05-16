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

frontwebapp_name           = "auto-auth-front-prod"
backwebapp_name            = "auto-auth-back-prod"
private_endpoint_name      = "auto-auth-private-endpoint-prod"
dns_private_zone_name      = "privatelink.azurewebsites.net"
private_dns_zone_link_name = "auto-auth-dns-zone-link-prod"

