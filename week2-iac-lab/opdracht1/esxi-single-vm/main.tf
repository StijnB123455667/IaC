resource "esxi_guest" "ubuntu_single" {
  guest_name         = var.vm_name
  disk_store         = var.disk_store
  guestos            = "ubuntu-64"
  boot_disk_type     = "thin"
  boot_disk_size     = "20"
  memsize            = "1024"
  numvcpus           = "1"
  resource_pool_name = "/"
  power              = "on"

  # Ubuntu 24.04 cloudimage/OVA. Zonder cloud-init gebruiker kun je de VM wel zien booten,
  # maar nog niet praktisch gebruiken. Dit past bij opdracht 1A.
  ovf_source = var.ubuntu_2404_ova_path

  network_interfaces {
    virtual_network = var.virtual_network
    nic_type        = "vmxnet3"
  }

  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}
