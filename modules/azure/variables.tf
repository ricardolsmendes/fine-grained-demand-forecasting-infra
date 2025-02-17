variable "project_name" {
  type        = string
  description = "The name of the project."
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
  description = "The name of the resource group."
  type        = string
}

variable "key_vault_ip_rules" {
  description = "List of public IP addresses to allow key vault access."
  type        = list(string)
  default     = []
}

variable "key_vault_virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs to allow key vault access."
  type        = list(string)
  default     = []
}
