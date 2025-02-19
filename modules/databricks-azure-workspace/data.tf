data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_databricks_access_connector" "this" {
  name                = var.databricks_access_connector_name
  resource_group_name = var.resource_group_name
}
