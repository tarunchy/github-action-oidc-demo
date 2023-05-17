resource_group_name     = "rg-its-sls-dev-wu-3"
key_vault_name     = "kv-its-az-1"
resource_group_location = "westus"
tags = {
  "cost_center" = "1234H"
  "PHI"         = "False"
}
vnet_address_space = ["10.0.0.0/27"]
subnet_prefixes    = ["10.0.0.0/29", "10.0.0.8/29", "10.0.0.16/29"]
vnet_name          = "vnet-its-sls-dev-wu-3"
subnet_names       = ["snet-its-sls-dev-wu-3-1", "snet-its-sls-dev-wu-3-2", "snet-its-sls-dev-wu-3-3"]

app_service_plan_name     = "its-sls-dev-wu-asp-3-1"
app_service_plan_sku_name = "P1v2"
app_service_always_on     = true

frontwebapp_name           = "csweb-app-1"
backwebapp_name            = "csapi-app-2"
private_endpoint_name      = "cs-hack-private-endpoint-dev"
dns_private_zone_name      = "privatelink.azurewebsites.net"
private_dns_zone_link_name = "cs-hack-dns-zone-link-dev"
app_tech_stack             = "PYTHON|3.11"
