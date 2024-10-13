# Azure Provider
terraform {
  required_version = ">=1.7.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }

  backend "azurerm" {}
}

# Microsoft Azure Provider
provider "azurerm" {
  features {}
}