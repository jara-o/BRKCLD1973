data "intersight_organization_organization" "org" {
  name = var.intersight_organization
}

data "intersight_compute_physical_summary" "server" {
    name = var.intersight_servers
}

data "intersight_os_configuration_file" "os_config" {
    name = var.os_config_file_name
}

data "intersight_storage_controller" "bootstoragecontroller" {
    type = "M.2-Hwraid"
    dn = "/redfish/v1/Systems/${data.intersight_compute_physical_summary.server.results[0].serial}/Storage/MSTOR-RAID"
}

data "intersight_storage_virtual_drive" "virtual_boot" {
    moid = data.intersight_storage_controller.bootstoragecontroller.results[0].virtual_drives[0].moid
}