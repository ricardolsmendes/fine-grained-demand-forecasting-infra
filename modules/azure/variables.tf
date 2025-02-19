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
  description = "The name of the resource group."
  type        = string
}

variable "networking_ip_rules" {
  description = "List of public IP addresses to allow resource access."
  type        = list(string)
  default     = []
}

variable "networking_virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs to allow resource access."
  type        = list(string)
  default     = []
}

# ===================================================================================== #
#                                   KAGGLE VARIABLES                                    #
# ===================================================================================== #
variable "kaggle_username" {
  description = "The Kaggle username to be stored as a secret value."
  type        = string
}

variable "kaggle_key" {
  description = "The Kaggle key to be stored as a secret value."
  type        = string
}
