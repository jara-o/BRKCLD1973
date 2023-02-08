data "intersight_organization_organization" "organization" {
  name = var.intersight_organization
}

data "intersight_compute_physical_summary" "server_moid" {
  for_each = toset(var.intersight_servers)
  name  = each.key
}