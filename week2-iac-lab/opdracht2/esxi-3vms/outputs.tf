output "esxi_vm_ips" {
  value = {
    for node in local.all_nodes : node.hostname => node.ip_address
  }
}

output "ssh_examples" {
  value = [
    for node in local.all_nodes : "ssh ${var.admin_username}@${node.ip_address}"
  ]
}
