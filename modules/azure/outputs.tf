output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "landing_storage_container_name" {
  value = azurerm_storage_container.landing.name
}

output "databricks_access_connector_name" {
  value = azurerm_databricks_access_connector.this.name
}
