provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "wgaz-resource-group"
  location = "East US"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "vpn" {
  source              = "./modules/wireguard-vpn"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  vpn_subnet          = var.vpn_subnet
  client_count        = var.client_count
}
