output "resource_group_name" {
  description = "Navnet på ressursgruppen som ble opprettet"
  value       = azurerm_resource_group.main.name
}

output "name_prefix" {
  description = "Navneprefikset alle ressursene dine deler"
  value       = local.name_prefix
}

output "vm_public_ip" {
  description = "Offentlig IP-adresse til VM-en"
  value       = azurerm_public_ip.pubip.ip_address
}