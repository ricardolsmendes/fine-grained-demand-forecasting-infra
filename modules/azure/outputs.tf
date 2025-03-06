output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "databricks_uc_metastore_storage_account_name" {
  value = azurerm_storage_account.databricks_uc_metastore.name
}

output "databricks_uc_metastore_container_name" {
  value = azurerm_storage_data_lake_gen2_filesystem.databricks_uc_metastore.name
}

output "databricks_access_connector_name" {
  value = azurerm_databricks_access_connector.this.name
}
