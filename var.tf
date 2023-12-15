variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Location for the Azure resources"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Azure Virtual Network"
  type        = string

}

variable "address_space" {
  description = "Address space for the Azure Virtual Network"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the Azure resources"
  type        = map(string)
}

variable "subnet_name" {
  description = "Name of the Azure Subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the Azure Subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the Azure Network Security Group"
  type        = string
}

variable "nsg_security_rule_name" {
  description = "Name of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_priority" {
  description = "Priority of the Azure Network Security Group Security Rule"
  type        = number
}

variable "nsg_security_rule_direction" {
  description = "Direction of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_access" {
  description = "Access type of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_protocol" {
  description = "Protocol of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_source_port_range" {
  description = "Source port range of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_destination_port_range" {
  description = "Destination port range of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_source_address_prefix" {
  description = "Source address prefix of the Azure Network Security Group Security Rule"
  type        = string
}

variable "nsg_security_rule_destination_address_prefix" {
  description = "Destination address prefix of the Azure Network Security Group Security Rule"
  type        = string
}

variable "subnet_nsg_association_name" {
  description = "Name of the Subnet Network Security Group Association"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Azure Public IP"
  type        = string
}

variable "network_interface_name" {
  description = "Name of the Azure Network Interface"
  type        = string
}

variable "ip_configuration_name" {
  description = "Name of the IP Configuration"
  type        = string
}

variable "private_ip_allocation" {
  description = "Private IP Address Allocation method"
  type        = string
}

variable "linux_vm_name" {
  description = "Name of the Linux Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
}

variable "admin_username" {
  description = "Username for the Virtual Machine"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}

variable "custom_data_template_path" {
  description = "Path to the custom data template file"
  type        = string
}

# variable "data_factory_name" {
#   description = "Name of the data factory"
#   type        = string
# }
