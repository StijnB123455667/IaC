output "vm_name" {
  description = "Naam van de gemaakte VM."
  value       = azurerm_linux_virtual_machine.main.name
}

output "public_ip" {
  description = "Public IP van de VM."
  value       = azurerm_public_ip.main.ip_address
}
