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

resource "azurerm_subnet" "test" {
  name                 = "subnet-${var.name_prefix}-test"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.67.0/24"]           # ledig blokk i 10.0.0.0/16
}