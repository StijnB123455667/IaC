output "public_ips" {
  value = {
    for i, ip in azurerm_public_ip.main : "vm-${i + 1}" => ip.ip_address
  }
}

output "ssh_commands" {
  value = [
    for i, ip in azurerm_public_ip.main : "ssh ${var.admin_username}@${ip.ip_address}"
  ]
}
