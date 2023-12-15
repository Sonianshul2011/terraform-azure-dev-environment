# Create resource group
resource "azurerm_resource_group" "az-tf-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Create virtual network
resource "azurerm_virtual_network" "az-tf-vn" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.az-tf-rg.location
  resource_group_name = azurerm_resource_group.az-tf-rg.name
  address_space       = var.address_space

  tags = var.tags
}

# Create Subnet
resource "azurerm_subnet" "az-tf-sn" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.az-tf-rg.name
  virtual_network_name = azurerm_virtual_network.az-tf-vn.name
  address_prefixes     = var.subnet_address_prefixes
}

# Create Network Security Group
resource "azurerm_network_security_group" "az-tf-nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.az-tf-rg.location
  resource_group_name = azurerm_resource_group.az-tf-rg.name

  # Set network security rule
  security_rule {
    name                       = var.nsg_security_rule_name
    priority                   = var.nsg_security_rule_priority
    direction                  = var.nsg_security_rule_direction
    access                     = var.nsg_security_rule_access
    protocol                   = var.nsg_security_rule_protocol
    source_port_range          = var.nsg_security_rule_source_port_range
    destination_port_range     = var.nsg_security_rule_destination_port_range
    source_address_prefix      = var.nsg_security_rule_source_address_prefix
    destination_address_prefix = var.nsg_security_rule_destination_address_prefix
  }

  tags = var.tags
}

# Create Subnet Network Security Group Association
resource "azurerm_subnet_network_security_group_association" "az-tf-snsga" {
  subnet_id                 = azurerm_subnet.az-tf-sn.id
  network_security_group_id = azurerm_network_security_group.az-tf-nsg.id
}

# Create Public IP
resource "azurerm_public_ip" "az-tf-pub-ip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.az-tf-rg.name
  location            = azurerm_resource_group.az-tf-rg.location
  allocation_method   = "Dynamic"

  tags = var.tags
}

# Create Network Interface
resource "azurerm_network_interface" "az-tf-nif" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.az-tf-rg.location
  resource_group_name = azurerm_resource_group.az-tf-rg.name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.az-tf-sn.id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.az-tf-pub-ip.id
  }

  tags = var.tags
}

# Create Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "az-tf-lvm" {
  name                = var.linux_vm_name
  resource_group_name = azurerm_resource_group.az-tf-rg.name
  location            = azurerm_resource_group.az-tf-rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.az-tf-nif.id,
  ]

  custom_data = filebase64(var.custom_data_template_path)

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = templatefile("windows-ssh-script.tpl", {
      hostname     = self.public_ip_address,
      user         = var.admin_username,
      identityfile = "~/.ssh/aztfazurekey"
    })
    interpreter = ["Powershell", "-Command"]
  }

  tags = var.tags
}

# Create Data Source for Public IP
data "azurerm_public_ip" "az-tf-ds" {
  name                = azurerm_public_ip.az-tf-pub-ip.name
  resource_group_name = azurerm_resource_group.az-tf-rg.name
}

# #Create Data Factory
# resource "azurerm_data_factory" "az-tf-df" {
#   name                = var.data_factory_name
#   location            = azurerm_resource_group.az-tf-rg.location
#   resource_group_name = azurerm_resource_group.az-tf-rg.name
# }
