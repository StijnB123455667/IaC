variable "prefix" {
  description = "Prefix voor Azure resources."
  type        = string
  default     = "iac-w2-opdr2"
}

variable "location" {
  description = "Azure regio."
  type        = string
  default     = "westeurope"
}

variable "admin_username" {
  description = "Admin user voor de VMs."
  type        = string
  default     = "iac"
}

variable "ssh_public_key_path" {
  description = "Lokaal pad naar de public SSH key."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "admin_source_ip_cidr" {
  description = "Bron IP/CIDR dat SSH mag gebruiken."
  type        = string
  default     = "0.0.0.0/0"
}
