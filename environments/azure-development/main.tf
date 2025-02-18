module "azure" {
  source = "../../modules/azure"

  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment

  resource_group_name                  = var.azure_resource_group_name
  key_vault_ip_rules                   = var.azure_key_vault_ip_rules
  key_vault_virtual_network_subnet_ids = var.azure_key_vault_virtual_network_subnet_ids

  kaggle_username = var.kaggle_username
  kaggle_key      = var.kaggle_key
}

module "databricks_azure_workspace" {
  source = "../../modules/databricks-azure-workspace"
  providers = {
    databricks = databricks.workspace
  }

  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment

  resource_group_name = var.azure_resource_group_name
  key_vault_name      = module.azure.key_vault_name
}
