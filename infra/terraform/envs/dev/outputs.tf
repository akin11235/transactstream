# -------------------------------
# Outputs
# -------------------------------
output "storage_account_name" {
  value = azurerm_storage_account.dev_sa.name
}

output "bronze_container_name" {
  value = module.bronze_container.container_name
}

output "silver_container_name" {
  value = module.silver_container.container_name
}

output "gold_container_name" {
  value = module.gold_container.container_name
}