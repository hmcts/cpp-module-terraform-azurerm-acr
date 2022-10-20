output "ACR_PDZID" {
  value = azurerm_private_dns_zone.acr-private-dns.*.id
}
output "ACR_name" {
  value = azurerm_container_registry.registry.name
}