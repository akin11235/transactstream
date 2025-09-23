# -------------------------------
# Variables
# -------------------------------
variable "location" {
  description = "Azure region"
  type        = string
  default     = "West US2"
}

variable "resource_group_name" {
  description = "Existing resource group for the Dev Box"
  type        = string
  default     = "transactStream-westUS2-rg"
}

variable "vm_name" {
  description = "Name of the Dev Box VM"
  type        = string
  default     = "tf-devbox"
}

variable "vm_admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "Size of the Dev Box VM"
  type        = string
  default     = "Standard_B2s"
}

variable "uami_name" {
  description = "User-assigned managed identity name"
  type        = string
  default     = "tf-uami"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
