output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "uc_catalog_root_storage_account_name" {
  value = azurerm_storage_account.uc_catalog_root.name
}

output "uc_catalog_root_container_name" {
  value = azurerm_storage_data_lake_gen2_filesystem.uc_catalog_root.name
}

output "databricks_access_connector_name" {
  value = azurerm_databricks_access_connector.this.name
}
