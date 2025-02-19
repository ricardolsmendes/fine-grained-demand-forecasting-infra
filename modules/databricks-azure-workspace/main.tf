resource "databricks_secret_scope" "this" {
  name = var.key_vault_name # Same as the underlying key vault.

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.this.id
    dns_name    = data.azurerm_key_vault.this.vault_uri
  }
}

resource "databricks_catalog" "this" {
  name    = replace("${var.project_short_name}-${var.environment}", "-", "_")
  comment = "Catalog used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

resource "databricks_schema" "landing" {
  catalog_name = databricks_catalog.this.name
  name         = "landing"
  comment      = "Landing layer used by the ${var.human_friendly_project_name} accelerator in the ${var.environment} environment."

  properties = {
    Project     = var.human_friendly_project_name
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}
