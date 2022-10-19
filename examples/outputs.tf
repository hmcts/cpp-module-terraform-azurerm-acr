output "RG" {
    description = "This prints the Resourve group Name and id"
    value       = azurerm_resource_group.acr-resource-grp.id
}

output "login_server" {
    description = "The URL that can be used to log into the container registry."
    value       = azurerm_container_registry.registry.login_server
}

output "admin_username" {
    description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
    value       = azurerm_container_registry.acr.admin_username
}