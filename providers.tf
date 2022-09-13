terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.21.1"
    }
  }
}


provider "azurerm" {
  
features {}
  subscription_id   = ""
  tenant_id         = ""
  client_id         = var.client_id
  client_secret     = var.client_secret
}
