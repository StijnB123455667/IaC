variable "esxi_hostname" {
  description = "Hostname of IP-adres van de ESXi host."
  type        = string
}

variable "esxi_hostport" {
  description = "SSH poort van de ESXi host."
  type        = string
  default     = "22"
}

variable "esxi_hostssl" {
  description = "SSL poort van de ESXi host."
  type        = string
  default     = "443"
}

variable "esxi_username" {
  description = "ESXi gebruikersnaam."
  type        = string
}

variable "esxi_password" {
  description = "ESXi wachtwoord."
  type        = string
  sensitive   = true
}

variable "disk_store" {
  description = "ESXi datastore."
  type        = string
  default     = "datastore1"
}

variable "virtual_network" {
  description = "ESXi portgroup/virtual network."
  type        = string
  default     = "VM Network"
}

variable "ubuntu_2404_ova_path" {
  description = "Pad of URL naar Ubuntu 24.04 cloudimage OVA."
  type        = string
}

variable "name_prefix" {
  description = "Prefix voor VM namen."
  type        = string
  default     = "iac-w2"
}

variable "admin_username" {
  description = "Gebruiker die via cloud-init wordt aangemaakt."
  type        = string
  default     = "iac"
}

variable "ssh_public_key_path" {
  description = "Pad naar je ED25519 public key."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "network_interface_name" {
  description = "Linux interface naam in de Ubuntu cloudimage. Vaak ens160 bij VMware."
  type        = string
  default     = "ens160"
}

variable "ip_prefix_length" {
  description = "Subnet prefix length, bijvoorbeeld 24."
  type        = number
  default     = 24
}

variable "gateway" {
  description = "Default gateway voor de ESXi VM's."
  type        = string
}

variable "dns_servers" {
  description = "DNS servers voor cloud-init netwerkconfiguratie."
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

variable "webserver_ips" {
  description = "Statische IP-adressen voor de twee webservers."
  type        = list(string)
}

variable "database_ip" {
  description = "Statisch IP-adres voor de databaseserver."
  type        = string
}
