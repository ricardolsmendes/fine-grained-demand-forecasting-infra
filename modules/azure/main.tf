# ===================================================================================== #
#                             KEY VAULT RELATED RESOURCES                               #
# ===================================================================================== #
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
    ip_rules                   = var.networking_ip_rules
    virtual_network_subnet_ids = var.networking_virtual_network_subnet_ids
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
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]
}

resource "azurerm_key_vault_secret" "kaggle_username" {
  name         = "kaggle-username"
  value        = var.kaggle_username
  key_vault_id = azurerm_key_vault.this.id

  tags = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_key_vault_secret" "kaggle_key" {
  name         = "kaggle-key"
  value        = var.kaggle_key
  key_vault_id = azurerm_key_vault.this.id

  tags = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

# ===================================================================================== #
#                           STORAGE ACCOUNT RELATED RESOURCES                           #
# ===================================================================================== #
# Storage account for the Unity Catalog metastore.
resource "azurerm_storage_account" "databricks_uc_metastore" {
  name                     = replace("${var.project_short_name}-${var.environment}", "-", "")
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true # Enables hierarchical namespace.

  tags = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

# Disabling the storage account network rules while we clarify the requirements.
# resource "azurerm_storage_account_network_rules" "this" {
#   storage_account_id         = azurerm_storage_account.databricks_uc_metastore.id
#   default_action             = "Deny"
#   ip_rules                   = var.networking_ip_rules
#   virtual_network_subnet_ids = var.networking_virtual_network_subnet_ids
# }

# Storage container for the Unity Catalog metastore.
resource "azurerm_storage_data_lake_gen2_filesystem" "databricks_uc_metastore" {
  name               = "uc-metastore-${var.environment}"
  storage_account_id = azurerm_storage_account.databricks_uc_metastore.id
}

# ===================================================================================== #
#                       DATABRICKS CONNECTIVITY RELATED RESOURCES                       #
# ===================================================================================== #
resource "azurerm_databricks_access_connector" "this" {
  name                = "${var.project_name}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  scope                = azurerm_storage_account.databricks_uc_metastore.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.this.identity[0].principal_id
}
