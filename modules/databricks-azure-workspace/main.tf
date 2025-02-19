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
#                           UNIT CATALOG RELATED RESOURCES                              #
# ===================================================================================== #
resource "databricks_catalog" "this" {
  name    = replace("${var.project_short_name}-${var.environment}", "-", "_")
  comment = "Catalog used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

# The data lake landing zone.
resource "databricks_schema" "landing" {
  catalog_name = databricks_catalog.this.name
  name         = "landing"
  comment      = "Landing zone used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "databricks_storage_credential" "this" {
  name = "${var.project_name}-${var.environment}"
  azure_managed_identity {
    access_connector_id = data.azurerm_databricks_access_connector.this.id
  }
  comment = "Used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."
}

resource "databricks_external_location" "landing" {
  name = "landing"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    var.landing_storage_container_name,
    var.storage_account_name
  )
  credential_name = databricks_storage_credential.this.id
  comment         = "Landing zone for the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."
}

resource "databricks_volume" "kaggle" {
  name             = "kaggle"
  catalog_name     = databricks_catalog.this.name
  schema_name      = databricks_schema.landing.name
  volume_type      = "EXTERNAL"
  storage_location = databricks_external_location.landing.url
  comment          = "Used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."
}
