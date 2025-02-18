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

variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Azure key vault."
  type        = string
}
