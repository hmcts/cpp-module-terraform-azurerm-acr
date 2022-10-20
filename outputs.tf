output "ACR_PDZID" {
  value = azurerm_private_dns_zone.acr-private-dns.*.id
}