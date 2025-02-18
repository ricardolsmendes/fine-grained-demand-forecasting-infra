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

# ===================================================================================== #
#                                    AZURE VARIABLES                                    #
# ===================================================================================== #
variable "azure_tenant_id" {
  description = "The directory (tenant) ID for the Azure provider."
  type        = string
}

variable "azure_subscription_id" {
  description = "The subscription ID for the Azure provider."
  type        = string
}

variable "azure_resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "azure_client_id" {
  description = "The app (client) ID used by Terraform to authenticate against Azure."
  type        = string
}

variable "azure_client_secret" {
  description = "Password used by Terraform to authenticate against Azure."
  type        = string
}

variable "azure_key_vault_ip_rules" {
  description = "List of public IP addresses to allow key vault access."
  type        = list(string)
  default     = []
}

variable "azure_key_vault_virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs to allow key vault access."
  type        = list(string)
  default     = []
}

# ===================================================================================== #
#                                 DATABRICKS VARIABLES                                  #
# ===================================================================================== #
variable "databricks_workspace_host" {
  description = "The Databricks workspace host."
  type        = string
}
