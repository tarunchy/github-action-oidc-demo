resource "azurerm_key_vault" "dev-key-vault" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.client_id

    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
      "Recover",
      "Backup",
      "Restore",
    ]
  }

}

resource "azurerm_key_vault_secret" "dev-key-vault_secret1" {
  name         = "openai-key"
  value        = "dummy"
  key_vault_id = azurerm_key_vault.dev-key-vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "dev-key-vault_secret2" {
  name         = "openai-url"
  value        = "dummy"
  key_vault_id = azurerm_key_vault.dev-key-vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


data "azurerm_client_config" "current" {}


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

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" : "1"
  }


}

