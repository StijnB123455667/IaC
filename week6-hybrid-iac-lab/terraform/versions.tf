terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    esxi = {
      source  = "josenk/esxi"
      version = "1.10.3"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
