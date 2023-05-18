# Azure Technology Stack using Terraform

This repository contains the Terraform code used to create an end-to-end technology stack in Azure for an application.

## Terraform Files

The Terraform files are organized sequentially:

1. `1_rg.tf` - This file creates the main Resource Group to which all Azure resources for this application belong.

  ```
   resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}
    ```bash

2. `2_vnet.tf` - This file sets up the VNET and Subnets with NSG for the application.

    ```
    resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "integrationsubnet" {
  name                 = "integrationsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[0]]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "endpointsubnet" {
  name                 = "endpointsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[1]]
  #private_endpoint_network_policies_enabled = true
  enforce_private_link_service_network_policies = true
}

resource "azurerm_subnet" "vmsubnet" {
  name                 = "vmsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[2]]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowOutboundHTTP"
    priority                   = 400
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowOutboundHTTPS"
    priority                   = 500
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "integrationsubnet_nsg" {
  subnet_id                 = azurerm_subnet.integrationsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "endpointsubnet_nsg" {
  subnet_id                 = azurerm_subnet.endpointsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "vmsubnet_nsg" {
  subnet_id                 = azurerm_subnet.vmsubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vmPublicIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}


resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vmsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}
    ```bash

3. `3_app_service.tf` - This file creates two app service instances. The first one is a front-end app exposed to the internet, and the second one is a backend app which is not exposed to the internet as it contains secrets like OpenAI API keys. The backend app is only accessible via resources in the VNET and private Link.

    ```
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
    "SCM_DO_BUILD_DURING_DEPLOYMENT" : "1",
    "WEBSITE_STARTUP_FILE" : "startup.sh"
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

    cors {
      allowed_origins     = ["*"]
      support_credentials = false
    }



  }

  identity {
    type = "SystemAssigned"
  }


  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" : "1",
    "SCM_DO_BUILD_DURING_DEPLOYMENT" : "1",
    "AZURE_OPENAI_KEY" : "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.rg-kv-dev-1.name};SecretName=AZURE-OPENAI-KEY)",
    "AZURE_OPENAI_ENDPOINT" : "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.rg-kv-dev-1.name};SecretName=AZURE-OPENAI-ENDPOINT)",
    "WEBSITE_STARTUP_FILE" : "startup.sh"
  }


}
    ```bash

4. `4_private_dns.tf` - This file sets up a DNS Zone for the App Service Backend.

    ```
    resource "azurerm_private_dns_zone" "dnsprivatezone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dnszonelink" {
  name                  = "dnszonelink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dnsprivatezone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
    ```bash

5. `5_private_endpoint.tf` - This file creates a private connection for the app service backend.

    ```
    resource "azurerm_private_endpoint" "privateendpoint" {
  name                = "backwebappprivateendpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.endpointsubnet.id

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.dnsprivatezone.id]
  }

  private_service_connection {
    name                           = "privateendpointconnection"
    private_connection_resource_id = azurerm_linux_web_app.backwebapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}
    ```bash

6. `6_vm.tf` - This file creates a VM for the GitHub Action Self-Hosted runner. This is necessary as we need a resource in the same VNET to deploy the app in the backend app service. The backend Python Flask-based API code is deployed using GitHub actions.

    ```
    variable "ssh_key_path" {
  description = "The path where the SSH key files will be created"
  default     = "~/.ssh/id_rsa_terraform"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vm"
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = "Standard_B2s"
  computer_name                   = "vm"
  admin_username                  = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${var.ssh_key_path}.pub")
  }

  os_disk {
    name                 = "osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
    ```bash

In addition to these, there are dedicated files for variables (`variable.tf`), environment-specific variables (`env.tfvars`), and data for non-Terraform managed existing resources (`data.tf`).


7. env.tfvars

```
resource_group_name     = "rg-its-sls-dev-wu-3"
key_vault_name          = "kv-its-az-1"
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

```bash