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
  description = "The name of the Azure Databricks access connector."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account used as an external location by UC."
  type        = string
}

variable "unity_catalog_metastore_container_name" {
  description = "Name of the storage container for the Unity Catalog metastore."
  type        = string
}
