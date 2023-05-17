resource "null_resource" "ssh_keygen" {
  provisioner "local-exec" {
    command = <<EOF
    ssh-keygen -t rsa -b 4096 -f ${var.ssh_key_path} -N ""
    EOF
  }
}


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

  depends_on = [null_resource.ssh_keygen]
}
