terraform {

  backend "local" {
    path = "/tmp/terraform_state/terraform.tfstate"
  }

  required_version = ">=0.12"
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.7.0"
    }
  }
}

provider "azurerm" {
  
  features {}
  use_oidc           = true
}

resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name      = random_pet.rg-name.id
  location  = var.resource_group_location
}
