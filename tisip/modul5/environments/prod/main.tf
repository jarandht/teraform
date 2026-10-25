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

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
}

module "stack" {
  source         = "../../stacks"
  name_prefix    = local.name_prefix
  location       = var.location
  rg_name        = azurerm_resource_group.main.name
  address_prefix = var.address_prefix
  address_space  = var.address_space
}