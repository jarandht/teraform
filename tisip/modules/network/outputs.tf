output "subnet_id" {
  value       = azurerm_subnet.app.id
  description = "ID til subnettet, til bruk for f.eks. en NIC."
}