locals {
  webservers = [
    for index, ip in var.webserver_ips : {
      hostname   = format("%s-webserver-%02d", var.name_prefix, index + 1)
      ip_address = ip
    }
  ]

  databaseserver = {
    hostname   = "${var.name_prefix}-databaseserver-01"
    ip_address = var.database_ip
  }

  all_nodes = concat(local.webservers, [local.databaseserver])
}

resource "esxi_guest" "webserver" {
  count = 2

  guest_name         = local.webservers[count.index].hostname
  disk_store         = var.disk_store
  guestos            = "ubuntu-64"
  boot_disk_type     = "thin"
  boot_disk_size     = "20"
  memsize            = "2048"
  numvcpus           = "1"
  resource_pool_name = "/"
  power              = "on"

  ovf_source = var.ubuntu_2404_ova_path

  network_interfaces {
    virtual_network = var.virtual_network
    nic_type        = "vmxnet3"
  }

  guestinfo = {
    "metadata"          = base64gzip(templatefile("${path.module}/cloud-init/meta-data.yml.tpl", {
      hostname               = local.webservers[count.index].hostname
      interface_name         = var.network_interface_name
      ip_address             = local.webservers[count.index].ip_address
      ip_prefix_length       = var.ip_prefix_length
      gateway                = var.gateway
      dns_servers            = var.dns_servers
    }))
    "metadata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(templatefile("${path.module}/cloud-init/user-data.yml.tpl", {
      admin_username = var.admin_username
      ssh_public_key = trimspace(file(var.ssh_public_key_path))
    }))
    "userdata.encoding" = "gzip+base64"
  }

  guest_startup_timeout  = 120
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "databaseserver" {
  guest_name         = local.databaseserver.hostname
  disk_store         = var.disk_store
  guestos            = "ubuntu-64"
  boot_disk_type     = "thin"
  boot_disk_size     = "20"
  memsize            = "2048"
  numvcpus           = "1"
  resource_pool_name = "/"
  power              = "on"

  ovf_source = var.ubuntu_2404_ova_path

  network_interfaces {
    virtual_network = var.virtual_network
    nic_type        = "vmxnet3"
  }

  guestinfo = {
    "metadata"          = base64gzip(templatefile("${path.module}/cloud-init/meta-data.yml.tpl", {
      hostname               = local.databaseserver.hostname
      interface_name         = var.network_interface_name
      ip_address             = local.databaseserver.ip_address
      ip_prefix_length       = var.ip_prefix_length
      gateway                = var.gateway
      dns_servers            = var.dns_servers
    }))
    "metadata.encoding" = "gzip+base64"
    "userdata"          = base64gzip(templatefile("${path.module}/cloud-init/user-data.yml.tpl", {
      admin_username = var.admin_username
      ssh_public_key = trimspace(file(var.ssh_public_key_path))
    }))
    "userdata.encoding" = "gzip+base64"
  }

  guest_startup_timeout  = 120
  guest_shutdown_timeout = 30
}

resource "local_file" "esxi_ips" {
  filename = "${path.module}/esxi_vm_ips.txt"
  content  = join("\n", concat([for node in local.all_nodes : format("%s %s", node.hostname, node.ip_address)], [""]))
}
