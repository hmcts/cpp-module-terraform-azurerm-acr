output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "acr_name" {
  value = module.registry.ACR_NAME
}
