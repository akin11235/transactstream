resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id    = var.storage_account_id   # updated
  container_access_type = var.access_type
}
