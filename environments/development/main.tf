module "azure" {
  source = "../../modules/azure"

  project_name                = var.project_name
  human_friendly_project_name = var.human_friendly_project_name
  environment                 = local.environment
  resource_group_name         = var.resource_group_name
}
