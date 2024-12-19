terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstateaslamdev01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  tenant_id       = "a31b95b5-eb3a-4309-bb4f-c7d7a6b215c3"
  subscription_id = "7124dc01-d1a8-4ccc-ad77-d00d99007f68"
}