![test](https://github.com/innovationnorway/terraform-cloudflare-ip-ranges/workflows/test/badge.svg)

# Cloudflare IP Ranges Module

Use this Terraform module to retrieve [Cloudflare IP ranges](https://www.cloudflare.com/ips/).

## Example Usage

```terraform
module "ip_ranges" {
  source = "innovationnorway/cloudflare/ip-ranges"
}

resource "azurerm_app_service" "example" {
  name = "example"

  ...

  site_config {
    dynamic "ip_restriction" {
      for_each = toset(module.ip_ranges.cidrs)

      content {
        ip_address = ip_restriction.key
      }
    }
  }
}
```
