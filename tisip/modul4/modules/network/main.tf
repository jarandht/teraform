resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-${var.project}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix
}