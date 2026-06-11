variable "prefix" {
  description = "Prefix voor Azure resources."
  type        = string
  default     = "iac-w2-opdr1"
}

variable "location" {
  description = "Azure regio."
  type        = string
  default     = "westeurope"
}

variable "admin_username" {
  description = "Admin user voor de VM."
  type        = string
  default     = "iac"
}

variable "ssh_public_key_path" {
  description = "Lokaal pad naar de public SSH key. Gebruik bij voorkeur je ED25519 public key."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "admin_source_ip_cidr" {
  description = "Bron IP/CIDR dat SSH mag gebruiken. Voor lab mag 0.0.0.0/0, maar beperkter is veiliger."
  type        = string
  default     = "0.0.0.0/0"
}
