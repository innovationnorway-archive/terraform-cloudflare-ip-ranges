data "http" "main" {
  url = "https://api.cloudflare.com/client/v4/ips"
}

locals {
  ip_ranges = jsondecode(data.http.main.body).result
}

output "cidrs" {
  value = concat(
    local.ip_ranges.ipv4_cidrs,
    local.ip_ranges.ipv6_cidrs
  )
  description = "List of CIDR blocks."
}

output "ipv4_cidrs" {
  value       = local.ip_ranges.ipv4_cidrs
  description = "List of IPv4 CIDR blocks."
}

output "ipv6_cidrs" {
  value       = local.ip_ranges.ipv6_cidrs
  description = "List of IPv6 CIDR blocks."
}
