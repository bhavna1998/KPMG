## NOTE: Read all given instructions before updating the values to get the resources created in first run.

module "kubernetes_services" {
  source              = "git::https://dev.azure.com/dmangeshtambe0819/_git/iac-azure-modules?path=/aks?ref=main"
  aks_additional_tags = var.aks_additional_tags
  aks_userpool        = var.aks_userpool
  depends_on = [
    module.resource_group,
    module.virtual_network,
    module.disk_encryption_set,
    module.user_managed_identity
  ]
}