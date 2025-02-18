resource "databricks_secret_scope" "this" {
  name = var.key_vault_name # Same as the underlying key vault.

  keyvault_metadata {
    resource_id = data.azurerm_key_vault.this.id
    dns_name    = data.azurerm_key_vault.this.vault_uri
  }
}
