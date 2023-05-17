resource "azurerm_service_plan" "appserviceplan" {
  name                = var.app_service_plan_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "frontwebapp" {
  name                = var.frontwebapp_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  site_config {
    always_on = var.app_service_always_on
  }
  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1"
  }
  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
  app_service_id  = azurerm_linux_web_app.frontwebapp.id
  subnet_id       = azurerm_subnet.integrationsubnet.id
}

resource "azurerm_linux_web_app" "backwebapp" {
  name                = var.backwebapp_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  site_config {
    always_on = var.app_service_always_on
  }
  tags = var.tags
}
