# -------------------------------
# Outputs
# -------------------------------
output "dev_vm_name" {
  value = azurerm_linux_virtual_machine.dev_vm.name
}

output "dev_vm_public_ip" {
  value = azurerm_public_ip.dev_vm_ip.ip_address
}

output "uami_client_id" {
  value = azurerm_user_assigned_identity.dev_uami.client_id
}

output "uami_principal_id" {
  value = azurerm_user_assigned_identity.dev_uami.principal_id
}

output "ssh_connection_command" {
  value = "ssh ${var.vm_admin_username}@${azurerm_public_ip.dev_vm_ip.ip_address}"
}