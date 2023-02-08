# Start OS Install 
resource "intersight_os_install" "os_install" {
  name = "InstallTemplate"

  server {
    object_type = data.intersight_compute_physical_summary.server.results[0].source_object_type
    moid        = data.intersight_compute_physical_summary.server.results[0].moid
  }
  image {
    object_type = "softwarerepository.OperatingSystemFile"
    moid        = intersight_softwarerepository_operating_system_file.os_repo.moid 
  }
  osdu_image {
    object_type = "firmware.ServerConfigurationUtilityDistributable"
    moid        = intersight_firmware_server_configuration_utility_distributable.scu_repo.moid 
  }
  configuration_file {
    object_type = "os.ConfigurationFile"
    moid        = data.intersight_os_configuration_file.os_config.results[0].moid
  }
  answers {
    hostname       = var.os_hostname
    ip_config_type = var.os_ip_config_type
    ip_configuration {
      additional_properties = jsonencode({
        IpV4Config = {
          IpAddress = var.os_ipv4_addr
          Netmask   = var.os_ipv4_netmask
          Gateway   = var.os_ipv4_gateway
        }
      })
      object_type = "os.Ipv4Configuration"
    }
    is_root_password_crypted = false
    nameserver               = var.os_ipv4_dns_ip
    root_password            = var.os_root_password
    nr_source                = var.os_answers_nr_source
  }
  operating_system_parameters {
    object_type = "os.VmwareParameters"
    additional_properties = jsonencode({
      vlanid = var.os_vlanid
    })
  }
  install_method = "vMedia"
  install_target {
    object_type = "os.VirtualDrive"
    additional_properties = jsonencode({
      ObjectType              = "os.VirtualDrive"
      Id                      = data.intersight_storage_virtual_drive.virtual_boot.results[0].virtual_drive_id
      Name                    = data.intersight_storage_virtual_drive.virtual_boot.results[0].name
      StorageControllerSlotId = data.intersight_storage_controller.bootstoragecontroller.results[0].controller_id
    })
  }

  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.org.results[0].moid
  }
}