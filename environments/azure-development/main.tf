# ===================================================================================== #
#                                 AZURE INFRASTRUCTURE                                  #
# ===================================================================================== #
module "azure" {
  source = "../../modules/azure"

  project_name                = var.project_name
  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment

  resource_group_name                   = var.azure_resource_group_name
  networking_ip_rules                   = var.azure_networking_ip_rules
  networking_virtual_network_subnet_ids = var.azure_networking_virtual_network_subnet_ids

  kaggle_username = var.kaggle_username
  kaggle_key      = var.kaggle_key
}

# ===================================================================================== #
#                              DATABRICKS INFRASTRUCTURE                                #
# ===================================================================================== #
module "databricks_azure_workspace" {
  source = "../../modules/databricks-azure-workspace"
  providers = {
    databricks = databricks.workspace
  }

  project_name                = var.project_name
  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment

  resource_group_name              = var.azure_resource_group_name
  key_vault_name                   = module.azure.key_vault_name
  storage_account_name             = module.azure.storage_account_name
  data_lake_landing_container_name = module.azure.data_lake_landing_container_name
  data_lake_layers                 = module.azure.data_lake_layers
  databricks_access_connector_name = module.azure.databricks_access_connector_name
}
