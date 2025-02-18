module "azure" {
  source = "../../modules/azure"

  project_name                = var.project_name
  project_short_name          = var.project_short_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment
  resource_group_name         = var.azure_resource_group_name
}
