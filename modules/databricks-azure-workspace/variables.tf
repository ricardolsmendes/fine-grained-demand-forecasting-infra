# ===================================================================================== #
#                                   PROJECT VARIABLES                                   #
# ===================================================================================== #
variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "project_short_name" {
  type        = string
  description = "The short name of the project."
}

variable "human_friendly_project_name" {
  type        = string
  description = "The human-friendly name of the project."
}

variable "environment" {
  type        = string
  description = "The deployment environment."
}

# ===================================================================================== #
#                                    AZURE VARIABLES                                    #
# ===================================================================================== #
variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Azure key vault."
  type        = string
}

variable "databricks_access_connector_name" {
  description = "The name of the Access Connector for Azure Databricks."
  type        = string
}

variable "catalog_root_storage_account_name" {
  description = "Name of the storage account where data for Unity Catalog managed assets will be stored."
  type        = string
}

variable "catalog_storage_root_container_name" {
  description = "Name of the container where data for Unity Catalog managed assets will be stored."
  type        = string
}
