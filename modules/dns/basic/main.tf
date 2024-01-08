# Disabled due to https://github.com/hashicorp/terraform-provider-google/issues/16832
# data "google_dns_managed_zone" "main" {
#   name = var.managed_zone
# }

locals {
  types   = ["A", "AAAA", "CNAME"]
  records = [var.ip_address, var.ipv6_address, var.name]
  rrdatas = [for r in local.records : r if r != ""]

  # If every record is empty, then the type is A, but this will be caught below.
  type = local.types[index(local.records, length(local.rrdatas) > 0 ? local.rrdatas[0] : "")]
}

resource "google_dns_record_set" "main" {
  # name         = "${var.subdomain}.${data.google_dns_managed_zone.main.dns_name}"
  # managed_zone = data.google_dns_managed_zone.main.name

  name         = "${var.subdomain}.${var.managed_zone_dns_name}"
  managed_zone = var.managed_zone
  type         = local.type
  ttl          = 300

  rrdatas = local.rrdatas

  lifecycle {
    precondition {
      condition     = length(local.rrdatas) > 0
      error_message = "Only one of ip_address, ipv6_address or name is supported."
    }
  }
}
