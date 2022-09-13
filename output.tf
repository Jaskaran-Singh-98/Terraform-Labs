output "resource_group_name" {
  value = azurerm_resource_group.rg-weu-dev.name
}
output "public_ip_address" {
    value = azurerm_windows_virtual_machine.vm-weu-dev.private_ip_address
}
