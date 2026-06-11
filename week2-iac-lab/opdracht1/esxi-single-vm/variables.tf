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
  description = "Gebruik SSL voor ESXi verbinding."
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
  description = "ESXi datastore waarop de VM wordt geplaatst."
  type        = string
  default     = "datastore1"
}

variable "virtual_network" {
  description = "Naam van het ESXi netwerk/portgroup."
  type        = string
  default     = "VM Network"
}

variable "ubuntu_2404_ova_path" {
  description = "Pad of URL naar de Ubuntu 24.04 cloudimage OVA."
  type        = string
}

variable "vm_name" {
  description = "Naam van de test VM."
  type        = string
  default     = "iac-opdracht1-ubuntu"
}
