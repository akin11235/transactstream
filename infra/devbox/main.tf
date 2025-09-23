
# -------------------------------
# Data source to get current subscription
# -------------------------------
data "azurerm_client_config" "current" {}

# -------------------------------
# Create User Assigned Managed Identity
# -------------------------------
resource "azurerm_user_assigned_identity" "dev_uami" {
  name                = var.uami_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# -------------------------------
# Networking: Virtual Network & Subnet
# -------------------------------
resource "azurerm_virtual_network" "dev_vnet" {
  name                = "tf-dev-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "dev_subnet" {
  name                 = "tf-dev-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dev_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# -------------------------------
# Network Security Group (recommended for security)
# -------------------------------
resource "azurerm_network_security_group" "dev_nsg" {
  name                = "tf-dev-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# -------------------------------
# Public IP
# -------------------------------
resource "azurerm_public_ip" "dev_vm_ip" {
  name                = "tf-dev-vm-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
# -------------------------------
# Network Interface
# -------------------------------
resource "azurerm_network_interface" "dev_vm_nic" {
  name                = "tf-dev-vm-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev_vm_ip.id
  }
}

# Associate Network Security Group to Network Interface
resource "azurerm_network_interface_security_group_association" "dev_nsg_association" {
  network_interface_id      = azurerm_network_interface.dev_vm_nic.id
  network_security_group_id = azurerm_network_security_group.dev_nsg.id
}

# -------------------------------
# Linux Virtual Machine
# -------------------------------
resource "azurerm_linux_virtual_machine" "dev_vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  
  # Disable password authentication and use SSH keys
  disable_password_authentication = true
  
  network_interface_ids = [azurerm_network_interface.dev_vm_nic.id]

  # You'll need to provide an SSH public key
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file("~/.ssh/id_rsa.pub") # Update this path to your SSH public key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.dev_uami.id]
  }
}

# -------------------------------
# Assign Contributor Role to UAMI on the RG
# -------------------------------
resource "azurerm_role_assignment" "uami_contributor" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.dev_uami.principal_id
}

