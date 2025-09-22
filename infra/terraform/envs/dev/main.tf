# Environment-specific orchestration
# Calls modules with dev-specific values

# -------------------------------
# Storage Account
# -------------------------------
resource "azurerm_storage_account" "dev_sa" {
  name                     = "transactstreamdev"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# -------------------------------
# ADLS Containers
# -------------------------------
module "bronze_container" {
  source             = "../../modules/adls_container"
  container_name     = "bronze-data"
  storage_account_id = azurerm_storage_account.dev_sa.id
  access_type        = "private"
}

module "silver_container" {
  source             = "../../modules/adls_container"
  container_name     = "silver-data"
  storage_account_id = azurerm_storage_account.dev_sa.id
  access_type        = "private"
}

module "gold_container" {
  source             = "../../modules/adls_container"
  container_name     = "gold-data"
  storage_account_id = azurerm_storage_account.dev_sa.id
  access_type        = "private"
}