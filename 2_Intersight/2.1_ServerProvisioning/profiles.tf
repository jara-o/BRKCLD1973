# Create service profiles based on template
resource "intersight_bulk_mo_cloner" "serverprofile" {
  for_each = toset(formatlist("%s", range(1, length(var.intersight_servers) + 1)))

  sources {
    object_type = intersight_server_profile_template.intersight_server_profile_template.object_type
    moid        = intersight_server_profile_template.intersight_server_profile_template.moid
  }

  targets {
    object_type = "server.Profile"
    additional_properties = jsonencode({
      Name = format("${var.env}-%s", substr(var.intersight_servers[each.key - 1], -1, 1)),
      AssignedServer = {
        Moid        = data.intersight_compute_physical_summary.server_moid[var.intersight_servers[each.key - 1]].results[0].moid,
        ObjectType  = data.intersight_compute_physical_summary.server_moid[var.intersight_servers[each.key - 1]].results[0].source_object_type,
      },
      Action = "Deploy",
    })
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [ intersight_server_profile_template.intersight_server_profile_template ]
  
}