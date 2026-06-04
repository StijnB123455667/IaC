variable "resource_group_name" {
  description = "Naam van de Azure resource group."
  type        = string
  default     = "rg-week5-iac-lab"
}

variable "location" {
  description = "Azure regio."
  type        = string
  default     = "westeurope"
}

variable "admin_username" {
  description = "Admin username voor de VM."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Publieke SSH key voor toegang tot de VM. Zet deze als GitHub secret TF_VAR_ssh_public_key."
  type        = string
  sensitive   = true
}
