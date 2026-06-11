provider "azurerm" {
  features {}

  subscription_id                 = var.azure_subscription_id
  resource_provider_registrations = "none"
}

provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = "22"
  esxi_hostssl  = "443"
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

locals {
  ssh_public_key = trimspace(file(var.ssh_public_key_path))

  azure_public_ip = var.deploy_azure ? azurerm_public_ip.azure[0].ip_address : ""
  esxi_ip         = var.deploy_esxi ? esxi_guest.esxi_vm[0].ip_address : ""
}

# --------------------
# Azure VM
# --------------------
data "azurerm_resource_group" "rg" {
  count = var.deploy_azure ? 1 : 0
  name  = var.azure_resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.deploy_azure ? 1 : 0
  name                = "${var.prefix}-vnet"
  address_space       = ["10.60.0.0/16"]
  location            = data.azurerm_resource_group.rg[0].location
  resource_group_name = data.azurerm_resource_group.rg[0].name
}

resource "azurerm_subnet" "subnet" {
  count                = var.deploy_azure ? 1 : 0
  name                 = "${var.prefix}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = ["10.60.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  count               = var.deploy_azure ? 1 : 0
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.rg[0].location
  resource_group_name = data.azurerm_resource_group.rg[0].name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "azure" {
  count               = var.deploy_azure ? 1 : 0
  name                = "${var.prefix}-azure-pip"
  resource_group_name = data.azurerm_resource_group.rg[0].name
  location            = data.azurerm_resource_group.rg[0].location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "azure" {
  count               = var.deploy_azure ? 1 : 0
  name                = "${var.prefix}-azure-nic"
  location            = data.azurerm_resource_group.rg[0].location
  resource_group_name = data.azurerm_resource_group.rg[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.azure[0].id
  }
}

resource "azurerm_network_interface_security_group_association" "azure" {
  count                     = var.deploy_azure ? 1 : 0
  network_interface_id      = azurerm_network_interface.azure[0].id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}

resource "azurerm_linux_virtual_machine" "azure" {
  count               = var.deploy_azure ? 1 : 0
  name                = "${var.prefix}-azure-vm"
  computer_name       = "azure-vm"
  location            = data.azurerm_resource_group.rg[0].location
  resource_group_name = data.azurerm_resource_group.rg[0].name
  size                = var.azure_vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.azure[0].id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/templates/azure-cloud-init.yml.tpl", {
    username       = var.admin_username
    ssh_public_key = local.ssh_public_key
  }))
}

# --------------------
# ESXi VM
# --------------------
resource "esxi_guest" "esxi_vm" {
  count                 = var.deploy_esxi ? 1 : 0
  guest_name            = "${var.prefix}-esxi-vm"
  disk_store            = var.esxi_datastore
  ovf_source            = var.esxi_ova_path
  memsize               = var.esxi_vm_memory_mb
  numvcpus              = var.esxi_vm_vcpu
  guestos               = "ubuntu-64"
  boot_firmware         = var.esxi_boot_firmware
  power                 = "on"
  guest_startup_timeout = 300

  network_interfaces {
    virtual_network = var.esxi_network
    nic_type        = "vmxnet3"
  }

  guestinfo = {
    "metadata" = base64encode(templatefile("${path.module}/templates/esxi-meta-data.yml.tpl", {
      instance_id    = "${var.prefix}-esxi-vm"
      local_hostname = "esxi-vm"
    }))
    "metadata.encoding" = "base64"
    "userdata" = base64encode(templatefile("${path.module}/templates/esxi-user-data.yml.tpl", {
      username       = var.admin_username
      ssh_public_key = local.ssh_public_key
    }))
    "userdata.encoding" = "base64"
  }
}

# --------------------
# Generated local files
# --------------------
resource "local_file" "inventory" {
  filename = "${path.module}/generated/inventory.ini"
  content = templatefile("${path.module}/templates/inventory.ini.tpl", {
    admin_username = var.admin_username
    azure_ip       = local.azure_public_ip
    esxi_ip        = local.esxi_ip
    deploy_azure   = var.deploy_azure
    deploy_esxi    = var.deploy_esxi
  })
}

resource "local_file" "azure_ip" {
  filename = "${path.module}/generated/azure_ip.txt"
  content  = local.azure_public_ip
}

resource "local_file" "esxi_ip" {
  filename = "${path.module}/generated/esxi_ip.txt"
  content  = local.esxi_ip
}
