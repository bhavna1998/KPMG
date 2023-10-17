module "storageaccount" {
  source              = "git::https://dev.azure.com/dmangeshtambe0819/_git/iac-azure-modules?path=/storageaccount?ref=main"
  storage_accounts    = var.storage_accounts
  containers          = var.containers
  file_shares         = var.file_shares
  blobs               = var.blobs
  queues              = var.queues
  tables              = var.tables
  key_vault_name      = var.key_vault_name
  key_vault_rg_name   = var.key_vault_rg_name
  depends_on          = [module.resource_group, module.key_vault, module.virtualnetwork]
}
