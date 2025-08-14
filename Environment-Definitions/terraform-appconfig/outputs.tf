# App Configuration Store outputs
output "app_configuration_id" {
  description = "The ID of the App Configuration store"
  value       = azurerm_app_configuration.config_store.id
}

output "app_configuration_name" {
  description = "The name of the App Configuration store"
  value       = azurerm_app_configuration.config_store.name
}

output "app_configuration_endpoint" {
  description = "The endpoint URL of the App Configuration store"
  value       = azurerm_app_configuration.config_store.endpoint
}

output "app_configuration_location" {
  description = "The Azure location of the App Configuration store"
  value       = azurerm_app_configuration.config_store.location
}

output "app_configuration_resource_group_name" {
  description = "The resource group name containing the App Configuration store"
  value       = azurerm_app_configuration.config_store.resource_group_name
}

output "app_configuration_sku" {
  description = "The SKU of the App Configuration store"
  value       = azurerm_app_configuration.config_store.sku
}

# Key-value outputs
output "app_configuration_keys" {
  description = "The keys created in the App Configuration store"
  value       = azurerm_app_configuration_key.config_store_key_value[*].key
}

output "app_configuration_key_values" {
  description = "The key-value pairs created in the App Configuration store"
  value = {
    for idx, key_config in azurerm_app_configuration_key.config_store_key_value : 
    key_config.key => {
      key          = key_config.key
      label        = key_config.label
      value        = key_config.value
      content_type = key_config.content_type
      etag         = key_config.etag
      locked       = key_config.locked
    }
  }
}

output "reference_key_value_value" {
  description = "The value of the first key-value pair"
  value       = azurerm_app_configuration_key.config_store_key_value[0].value
}

# Resource group output
output "resource_group_name" {
  description = "The name of the resource group used"
  value       = data.azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "The location of the resource group used"
  value       = data.azurerm_resource_group.main.location
}
