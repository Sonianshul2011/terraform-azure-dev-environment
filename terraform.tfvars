resource_group_name = "az-tf-demo"
location            = "East US"

tags = {
  environment = "dev"
}

virtual_network_name = "az-virtual-network"
address_space        = ["10.0.0.0/16"]

subnet_name             = "az-subnet"
subnet_address_prefixes = ["10.0.1.0/24"]

nsg_name                                     = "az-network-security-group"
nsg_security_rule_name                       = "az-tf-sec-rule"
nsg_security_rule_priority                   = 100
nsg_security_rule_direction                  = "Inbound"
nsg_security_rule_access                     = "Allow"
nsg_security_rule_destination_address_prefix = "*"
nsg_security_rule_destination_port_range     = "*"
nsg_security_rule_protocol                   = "*"
nsg_security_rule_source_address_prefix      = "*"
nsg_security_rule_source_port_range          = "*"
subnet_nsg_association_name                  = "az-tf-snsga"

public_ip_name         = "az-public-ip"
network_interface_name = "az-network-interface"
ip_configuration_name  = "internal"
private_ip_allocation  = "Dynamic"

linux_vm_name       = "az-linux-vm"
vm_size             = "Standard_F2"
admin_username      = "adminuser"
ssh_public_key_path = "~/.ssh/aztfazurekey.pub"

custom_data_template_path = "customdata.tpl"

#data_factory_name = "az-data-factory-demo"