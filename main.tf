resource "azurerm_resource_group" "rg-weu-dev" {
    name = var.resource_group_name
    location = var.resource_group_location
}

# Create Azure Virtual Network
resource "azurerm_virtual_network" "vnet-weu-dev" {
    name = "vnet-weu-dev"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg-weu-dev.location
    resource_group_name = azurerm_resource_group.rg-weu-dev.name
}

# Create Subnet
resource "azurerm_subnet" "sub-weu-dev" {
     name = "sub-weu-dev"
     resource_group_name = azurerm_resource_group.rg-weu-dev.name
     virtual_network_name = azurerm_virtual_network.vnet-weu-dev.name
     address_prefixes     = ["10.0.2.0/24"]
     depends_on = [
       azurerm_virtual_network.vnet-weu-dev
     ]
}

# Create Network Interface

resource "azurerm_network_interface" "nic-weu-dev" {
     name = "nic-weu-dev"
     location = azurerm_resource_group.rg-weu-dev.location
     resource_group_name = azurerm_resource_group.rg-weu-dev.name

     ip_configuration {
         name = "internal"
         subnet_id = azurerm_subnet.sub-weu-dev.id
         private_ip_address_allocation = "Dynamic"
        }
    depends_on = [
      azurerm_virtual_network.vnet-weu-dev
    ]
}

# Create Window Virtual Machine

resource "azurerm_windows_virtual_machine" "vm-weu-dev" {
     name = "vm-weu-dev"
     resource_group_name = azurerm_resource_group.rg-weu-dev.name
     location = azurerm_resource_group.rg-weu-dev.location
     size                = "Standard_F2"
     admin_username      = "adminuser"
     admin_password      = "P@$$w0rd1234!"

     network_interface_ids = [ azurerm_network_interface.nic-weu-dev.id ]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2016-Datacenter"
        version   = "latest"
    }

}