module "azure" {
  source = "../../modules/azure"

  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment
  resource_group_name         = var.azure_resource_group_name
}

module "databricks_azure_workspace" {
  source = "../../modules/databricks-azure-workspace"
  providers = {
    databricks = databricks.workspace
  }

  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment
  resource_group_name         = var.azure_resource_group_name
  key_vault_name              = module.azure.key_vault_name
}
