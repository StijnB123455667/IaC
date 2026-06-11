variable "prefix" {
  description = "Prefix for all resources."
  type        = string
  default     = "week6"
}

variable "admin_username" {
  description = "Linux user created on both VMs. The assignment requires testuser."
  type        = string
  default     = "testuser"
}

variable "ssh_public_key_path" {
  description = "Path to the ED25519 public key on the control machine."
  type        = string
}

variable "deploy_azure" {
  description = "Set true to deploy the Azure VM."
  type        = bool
  default     = true
}

variable "deploy_esxi" {
  description = "Set true to deploy the ESXi VM."
  type        = bool
  default     = true
}

variable "azure_subscription_id" {
  description = "Azure subscription ID from az account show."
  type        = string
}

variable "azure_location" {
  description = "Azure region."
  type        = string
  default     = "westeurope"
}

variable "azure_resource_group_name" {
  description = "Azure resource group name."
  type        = string
  default     = "rg-week6-hybrid-iac"
}

variable "azure_vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "esxi_hostname" {
  description = "ESXi host IP or DNS name."
  type        = string
  default     = "192.168.1.114"
}

variable "esxi_username" {
  description = "ESXi username."
  type        = string
  default     = "root"
}

variable "esxi_password" {
  description = "ESXi password. Keep this only in terraform.tfvars, never in GitHub."
  type        = string
  sensitive   = true
}

variable "esxi_datastore" {
  description = "ESXi datastore name."
  type        = string
  default     = "Storage01"
}

variable "esxi_network" {
  description = "ESXi portgroup/network name."
  type        = string
  default     = "VM Network"
}

variable "esxi_ova_path" {
  description = "Local path on the control machine to the Ubuntu 24.04 OVA."
  type        = string
  default     = "/home/student/iac/images/noble-server-cloudimg-amd64.ova"
}

variable "esxi_vm_memory_mb" {
  description = "ESXi VM memory in MB."
  type        = number
  default     = 2048
}

variable "esxi_vm_vcpu" {
  description = "ESXi VM vCPU count."
  type        = number
  default     = 1
}

variable "esxi_boot_firmware" {
  description = "ESXi boot firmware for the Ubuntu cloud image. Try efi first; change to bios if the VM does not boot."
  type        = string
  default     = "efi"
}
