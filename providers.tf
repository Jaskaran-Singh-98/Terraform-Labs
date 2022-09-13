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
  subscription_id   = "0c8c279f-5618-4db7-84ca-bf2c35a0f1c9"
  tenant_id         = "35617090-32da-4e6b-8682-91a80a1059cb"
  client_id         = var.client_id
  client_secret     = var.client_secret
}