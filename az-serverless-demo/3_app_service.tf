resource "azurerm_service_plan" "appserviceplan" {
  name                = "appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "frontwebapp" {
  name                = var.frontwebapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {

    application_stack {
      python_version = "3.9"
    }

  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITE_DNS_SERVER" : "168.63.129.16",
    "WEBSITE_VNET_ROUTE_ALL" : "1",
    "WEBSITE_RUN_FROM_PACKAGE" : "1",
  }


}

resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {
  app_service_id = azurerm_linux_web_app.frontwebapp.id
  subnet_id      = azurerm_subnet.integrationsubnet.id
}

resource "azurerm_linux_web_app" "backwebapp" {
  name                = var.backwebapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {

    application_stack {
      python_version = "3.9"
    }

  }

  identity {
    type = "SystemAssigned"
  }


  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" : "1",
    "AZURE_OPENAI_KEY" : "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.rg-kv-dev-1.name};SecretName=AZURE-OPENAI-KEY)",
    "AZURE_OPENAI_ENDPOINT" : "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.rg-kv-dev-1.name};SecretName=AZURE-OPENAI-ENDPOINT)"
  }


}

