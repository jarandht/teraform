resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name_prefix}"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-${var.name_prefix}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix
}