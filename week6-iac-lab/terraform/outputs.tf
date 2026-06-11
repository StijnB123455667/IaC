output "azure_public_ip" {
  description = "Public IP of the Azure VM."
  value       = var.deploy_azure ? azurerm_public_ip.azure[0].ip_address : null
}

output "esxi_vm_ip" {
  description = "IP of the ESXi VM as reported by VMware tools."
  value       = var.deploy_esxi ? esxi_guest.esxi_vm[0].ip_address : null
}

output "inventory_path" {
  description = "Generated Ansible inventory path."
  value       = local_file.inventory.filename
}

output "next_steps" {
  value = <<EOT
After apply:
1. Test SSH to Azure: ssh ${var.admin_username}@<azure_public_ip>
2. Test SSH to ESXi VM: ssh ${var.admin_username}@<esxi_vm_ip>
3. Run Ansible: cd .. && ansible-playbook -i terraform/generated/inventory.ini ansible/playbooks/site.yml
4. From ESXi VM test: ssh azure-vm
EOT
}
