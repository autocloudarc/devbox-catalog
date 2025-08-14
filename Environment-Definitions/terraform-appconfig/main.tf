# Configure the Azure Provider and version constraints for any 4.x version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create the App Configuration Store
resource "azurerm_app_configuration" "config_store" {
  name                = var.name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "standard"
}

# Data source to get the current resource group
data "azurerm_resource_group" "main" {
  name = "rg-${var.name}"
}

# Create key-value pairs in the App Configuration Store
resource "azurerm_app_configuration_key" "config_store_key_value" {
  count                  = length(var.key_value_names)
  configuration_store_id = azurerm_app_configuration.config_store.id
  key                    = split("$", var.key_value_names[count.index])[0]
  label                  = length(split("$", var.key_value_names[count.index])) > 1 ? split("$", var.key_value_names[count.index])[1] : null
  value                  = var.key_value_values[count.index]
  content_type          = var.content_type
  tags                  = var.tags
}

# Output the first key-value pair's value
output "reference_key_value_value" {
  description = "The value of the first key-value pair"
  value       = azurerm_app_configuration_key.config_store_key_value[0].value
}
