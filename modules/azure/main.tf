resource "azurerm_key_vault" "this" {
  name                       = "${var.project_short_name}-${var.environment}"
  location                   = data.azurerm_resource_group.this.location
  resource_group_name        = data.azurerm_resource_group.this.name
  tenant_id                  = data.azurerm_client_config.this.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  enable_rbac_authorization  = false

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = var.key_vault_ip_rules
    virtual_network_subnet_ids = var.key_vault_virtual_network_subnet_ids
  }

  tags = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.this.tenant_id
  object_id    = data.azurerm_client_config.this.object_id

  secret_permissions = [
    "Delete",
    "Get",
    "Set"
  ]
}

# ===================================================================================== #
#                                     AZURE SECRETS                                     #
#                                                                                       #
# Created with Terraform to avoid manual updates to the key vault.                      #
# ===================================================================================== #
resource "azurerm_key_vault_secret" "kaggle_username" {
  name         = "kaggle-username"
  value        = var.kaggle_username
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "kaggle_key" {
  name         = "kaggle-key"
  value        = var.kaggle_key
  key_vault_id = azurerm_key_vault.this.id
}
