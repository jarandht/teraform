terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  # subscription_id hentes fra ARM_SUBSCRIPTION_ID
}

module "name" {
  source              = "./modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_prefix      = var.address_prefix
  address_space       = var.address_space
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
}