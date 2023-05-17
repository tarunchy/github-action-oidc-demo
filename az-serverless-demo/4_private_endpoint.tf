resource "azurerm_private_endpoint" "pe" {
  name                = var.private_endpoint_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet[1].id

  private_service_connection {
    name                           = "${var.private_endpoint_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_linux_web_app.backwebapp.id
    subresource_names              = ["sites"]
  }
}
