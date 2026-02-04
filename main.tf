terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "local" {
    path     = "./terraform.tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
}
