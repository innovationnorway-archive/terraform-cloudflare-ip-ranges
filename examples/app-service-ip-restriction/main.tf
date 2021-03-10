module "ip_ranges" {
  source = "../../"
}

resource "random_id" "example" {
  byte_length = 4
}

resource "azurerm_resource_group" "example" {
  name     = "example-${random_id.example.hex}"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-${random_id.example.hex}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name = "example-${random_id.example.hex}"

  location = azurerm_resource_group.example.location

  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dynamic "ip_restriction" {
      for_each = toset(module.ip_ranges.cidrs)

      content {
        ip_address = ip_restriction.key
      }
    }
  }
}
