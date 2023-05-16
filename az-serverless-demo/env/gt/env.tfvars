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
app_service_plan_kind     = "Linux"
app_service_plan_reserved = true
app_service_plan_sku_tier = "P1v2"
app_service_plan_sku_size = "1"
linux_fx_version = "PYTHON|3.9"
app_service_always_on     = true
