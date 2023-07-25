output "ACR_PDZID" {
  value = azurerm_private_dns_zone.acr-private-dns.*.id
}
output "ACR_NAME" {
  value = azurerm_container_registry.registry.name
}
output "acr_private_dns_zone_id" {
  value = azurerm_private_dns_zone.acr-private-dns.id
}
