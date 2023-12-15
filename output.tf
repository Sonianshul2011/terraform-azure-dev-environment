output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.az-tf-lvm.name}: ${data.azurerm_public_ip.az-tf-ds.ip_address}"
}