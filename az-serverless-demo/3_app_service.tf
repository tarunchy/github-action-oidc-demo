resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  os_type             = "Linux"

  sku_name = "${var.app_service_plan_sku_tier}_${var.app_service_plan_sku_size}"

  tags = var.tags
}

resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    linux_fx_version = var.linux_fx_version
    always_on        = var.app_service_always_on
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
