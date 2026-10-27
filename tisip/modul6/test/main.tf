terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {}   # konfigureres via -backend-config
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}

module "name" {
  source         = "./modules/network"
  name_prefix    = var.name_prefix
  location       = var.location
  rg_name        = azurerm_resource_group.main.name
  address_prefix = var.address_prefix
  address_space  = var.address_space
}