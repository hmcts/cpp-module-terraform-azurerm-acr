terraform {
  required_version = ">= 0.12.20"
}

provider "azurerm" {
  version = "~>3.26.0"
  features {}
}
