# ===================================================================================== #
#                           SECRET SCOPE RELATED RESOURCES                              #
# ===================================================================================== #
resource "databricks_secret_scope" "this" {
  name = var.key_vault_name # Same as the underlying key vault.

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.this.id
    dns_name    = data.azurerm_key_vault.this.vault_uri
  }
}

# ===================================================================================== #
#                            UNIT CATALOG RELATED RESOURCES                             #
# ===================================================================================== #
resource "databricks_storage_credential" "this" {
  name = "${var.project_name}-${var.environment}"
  azure_managed_identity {
    access_connector_id = data.azurerm_databricks_access_connector.this.id
  }
  comment = "Used by the ${var.human_friendly_project_name} in the ${var.environment} environment."
}

resource "databricks_external_location" "uc_metastore" {
  name = "${var.project_short_name}-uc-metastore-${var.environment}"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    var.uc_metastore_container_name,
    var.uc_metastore_storage_account_name
  )
  credential_name = databricks_storage_credential.this.id
  comment         = "Unity Catalog metastore for the ${var.human_friendly_project_name} in the ${var.environment} environment."
}

resource "databricks_catalog" "this" {
  name         = replace("${var.project_short_name}-${var.environment}", "-", "_")
  storage_root = databricks_external_location.uc_metastore.url
  comment      = "Catalog used by the ${var.human_friendly_project_name} in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

# The data lake layers.
resource "databricks_schema" "dl_layers" {
  for_each = local.data_lake_layers

  catalog_name = databricks_catalog.this.name
  name         = each.value.name
  comment      = "Data lake ${each.value.name} layer used by the ${var.human_friendly_project_name} in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}
