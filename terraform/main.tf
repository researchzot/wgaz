terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "wgaz" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "wgaz" {
  name                = "wgaz-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.wgaz.location
  resource_group_name = azurerm_resource_group.wgaz.name
}

resource "azurerm_subnet" "wgaz" {
  name                 = "wgaz-subnet"
  resource_group_name  = azurerm_resource_group.wgaz.name
  virtual_network_name = azurerm_virtual_network.wgaz.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "wgaz" {
  name                = "wgaz-nsg"
  location            = azurerm_resource_group.wgaz.location
  resource_group_name = azurerm_resource_group.wgaz.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.wgaz.name
  network_security_group_name = azurerm_network_security_group.wgaz.name
}

resource "azurerm_network_security_rule" "allow_wireguard" {
  name                        = "allow_wireguard"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "51820"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.wgaz.name
  network_security_group_name = azurerm_network_security_group.wgaz.name
}

resource "azurerm_subnet_network_security_group_association" "wgaz" {
  subnet_id                 = azurerm_subnet.wgaz.id
  network_security_group_id = azurerm_network_security_group.wgaz.id
}

resource "azurerm_public_ip" "wgaz" {
  name                = "wgaz-publicip"
  location            = azurerm_resource_group.wgaz.location
  resource_group_name = azurerm_resource_group.wgaz.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "wgaz" {
  name                = "wgaz-nic"
  location            = azurerm_resource_group.wgaz.location
  resource_group_name = azurerm_resource_group.wgaz.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.wgaz.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wgaz.id
  }
}

resource "azurerm_linux_virtual_machine" "wgaz" {
  name                  = "wgaz-vm"
  location              = azurerm_resource_group.wgaz.location
  resource_group_name   = azurerm_resource_group.wgaz.name
  network_interface_ids = [azurerm_network_interface.wgaz.id]
  size                  = "Standard_B1s"

  admin_username = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_ed25519.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}

