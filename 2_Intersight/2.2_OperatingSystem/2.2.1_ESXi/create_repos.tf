# Add OS link to Intersight
resource "intersight_softwarerepository_operating_system_file" "os_repo" {
  name        = var.os_repo_name
  nr_version  = var.os_repo_nr_version
  vendor      = var.os_repo_vendor

  catalog {
    selector    = "Name eq 'user-catalog' and Organization/Moid eq '${data.intersight_organization_organization.org.results[0].moid}'"
    object_type = "softwarerepository.Catalog"
  }

  nr_source {
    object_type = "softwarerepository.HttpServer"
    additional_properties = jsonencode({
      LocationLink = var.os_repo_source_os_iso_path
    })
  }
}

# Add SCU link to Intersight
resource "intersight_firmware_server_configuration_utility_distributable" "scu_repo" {
  name             = var.scu_repo_name
  nr_version       = var.scu_nr_version
  supported_models = var.scu_supported_models

  catalog {
    selector    = "Name eq 'user-catalog' and Organization/Moid eq '${data.intersight_organization_organization.org.results[0].moid}'"
    object_type = "softwarerepository.Catalog"
  }

  nr_source {
    object_type = "softwarerepository.HttpServer"
    additional_properties = jsonencode({
      LocationLink = var.repo_source_scu_iso_path
    })
  }
}