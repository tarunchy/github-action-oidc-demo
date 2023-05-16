resource "azurerm_private_dns_zone" "pdz" {
  name                = var.dns_private_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "pdar" {
  name                = var.backwebapp_name
  zone_name           = azurerm_private_dns_zone.pdz.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pe.private_service_connection.0.private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdzvnl" {
  name                  = var.private_dns_zone_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pdz.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}
