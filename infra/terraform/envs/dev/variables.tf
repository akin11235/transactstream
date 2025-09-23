# Environment-specific variables

variable "location" {
  type    = string
  default = "West US2"
}

# Use existing resource group
variable "resource_group_name" {
  default = "transactStream-westUS2-rg"
}

variable "uami_client_id" {
  description = "Client ID of the user-assigned managed identity"
  type        = string
}
