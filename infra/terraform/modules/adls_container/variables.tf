variable "container_name" {
  description = "The name of the ADLS container"
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the storage account"
  type        = string
}

variable "access_type" {
  description = "Access type of the container (private, blob, container)"
  type        = string
  default     = "private"
}
