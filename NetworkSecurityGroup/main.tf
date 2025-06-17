terraform {
  required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "4.27.0"
    }
  }
}
provider "azurerm" {
  # Configuration options
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
}
data "azurerm_resource_group" "AZrg101" {
  name = "AZrg1011"
}
resource "azurerm_virtual_network" "AZvnet101" {
  name = "AZvnet1011"
  location = data.azurerm_resource_group.AZrg101.location
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  address_space = ["10.60.0.0/16"]
  tags = {
    "key" = "myVnet1011"
  }
}