# Create Template and attach policies
resource "intersight_server_profile_template" "intersight_server_profile_template" {
  name            = var.env
  target_platform = var.intersight_targetplatform

  action = "Unassign"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }

  # UUID Pool
  uuid_pool {
    moid        = intersight_uuidpool_pool.uuidpool_pool.moid
    object_type = "uuidpool.Pool"
  }

  # BIOS
  policy_bucket {
    moid        = intersight_bios_policy.bios_policy.moid
    object_type = "bios.Policy"
  }

  # Boot Order
  policy_bucket {
    moid        = intersight_boot_precision_policy.boot_precision.moid
    object_type = "boot.PrecisionPolicy"
  }

  # IMC Access
  policy_bucket {
    moid        = intersight_access_policy.intersight_access_policy.moid
    object_type = "access.Policy"
  }

  # LAN Connectivity Policy
  policy_bucket {
    moid        = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy.moid
    object_type = "vnic.LanConnectivityPolicy"
  }

  # Storage Policy
  policy_bucket {
    moid        = intersight_storage_storage_policy.intersight_storage_storage_policy.moid
    object_type = "storage.StoragePolicy"
  }

}