terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id

  client_id     = var.tf_azure_client_id
  client_secret = var.tf_azure_client_secret

  resource_provider_registrations = "none"
}
