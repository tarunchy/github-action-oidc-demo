data "azurerm_key_vault" "rg-kv-dev-1" {
  name                = "rg-kv-dev-1"
  resource_group_name = "rg-its-kv-dev"
}
