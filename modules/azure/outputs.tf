output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "data_lake_landing_container_name" {
  value = azurerm_storage_container.dl_landing.name
}

output "data_lake_layers" {
  value = {
    for k, v in local.data_lake_layers : k => {
      name           = v.name
      container_name = azurerm_storage_data_lake_gen2_filesystem.dl_layers[v.name].name
    }
  }
}

output "databricks_access_connector_name" {
  value = azurerm_databricks_access_connector.this.name
}
