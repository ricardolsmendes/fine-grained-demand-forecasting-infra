terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.66.0"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id

  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
}

provider "databricks" {
  alias = "workspace"
  host  = var.databricks_workspace_host

  azure_tenant_id     = var.azure_tenant_id
  azure_client_id     = var.azure_client_id
  azure_client_secret = var.azure_client_secret
}
