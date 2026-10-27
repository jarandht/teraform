terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

# Den som er logget inn med az login akkurat nå
data "azurerm_client_config" "current" {}

provider "azurerm" {
  features {}

  # azurerm 5.x registrerer ingen resource providers automatisk.
  resource_providers_to_register = ["Microsoft.Storage", "Microsoft.KeyVault"]
}