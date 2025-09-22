# Sets cloud providers and credentials

provider "azurerm" {
  features {}

  # Use the system-assigned managed identity of the VM / Databricks cluster / agent
  use_msi       = true
  client_id     = var.uami_client_id

}