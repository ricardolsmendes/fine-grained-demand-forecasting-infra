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
