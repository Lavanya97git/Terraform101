terraform {
  backend "azurerm" {
    resource_group_name = "AZrg1011"
    storage_account_name = "storageweb1010"
    container_name = "prodtfstate"
    # key = "terraform.prodtfstate"
    access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
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
locals {
  setup_name = "newComp-hyd"
}
resource "azurerm_resource_group" "AZrg103" {
    name = "AZrg1031"
    location = "Central US"
    tags = {
        "name" = "${local.setup_name}RG1031"
    }
}
resource "azurerm_service_plan" "AZappSP103" {
    name = "devAZappplan1031"
    resource_group_name = azurerm_resource_group.AZrg103.name
    location = azurerm_resource_group.AZrg103.location
    sku_name = "S1"
    os_type = "Windows"
    tags = {
        "name" = "${local.setup_name}SP1031"
    }
  
}
resource "azurerm_windows_web_app" "AZwebapp103" {
    name = "AZwedapp1031"
    resource_group_name = azurerm_resource_group.AZrg103.name
    location = azurerm_resource_group.AZrg103.location
    service_plan_id = azurerm_service_plan.AZappSP103.id
    depends_on = [ azurerm_service_plan.AZappSP103 ]
    site_config {
      
    }
    tags = {
        "name" = "${local.setup_name}WebApp1031"
    }
}