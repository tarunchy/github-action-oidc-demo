terraform {

  backend "local" {
    path = "/tmp/terraform_state/aks_cluster1_demo.tfstate"
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