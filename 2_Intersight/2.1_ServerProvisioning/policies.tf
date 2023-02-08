# Create BIOS
resource "intersight_bios_policy" "bios_policy" {
  name = "${var.env}_BIOS"

  cpu_performance                 = "enterprise"
  dram_clock_throttling           = "Performance"
  direct_cache_access             = "enabled"
  enhanced_intel_speed_step_tech  = "enabled"
  execute_disable_bit             = "enabled"
  cpu_frequency_floor             = "enabled"
  intel_hyper_threading_tech      = "enabled"
  intel_turbo_boost_tech          = "enabled"
  intel_virtualization_technology = "enabled"
  processor_cstate                = "disabled"
  processor_c1e                   = "disabled"
  processor_c3report              = "disabled"
  processor_c6report              = "disabled"
  cpu_power_management            = "performance"
  cpu_energy_performance          = "performance"
  intel_vt_for_directed_io        = "enabled"
  numa_optimized                  = "enabled"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# Create Boot Order
resource "intersight_boot_precision_policy" "boot_precision" {
  name                     = "${var.env}_Boot"
  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false
  boot_devices {
    enabled     = true
    name        = "KVM-DVD"
    object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "kvm-mapped-dvd"
    })
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# Create IMC Access
resource "intersight_access_policy" "intersight_access_policy" {
  name        = "${var.env}_IMC_Access"
  inband_vlan = var.intersight_inbandvlan
  inband_ip_pool {
    object_type = "ippool.Pool"
    moid        = intersight_ippool_pool.intersight_ip_pool.id
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# Create LAN Connectivity Policy and associated policies and interfaces
resource "intersight_vnic_lan_connectivity_policy" "intersight_vnic_lan_connectivity_policy" {
  name                = "${var.env}_LAN_Connectivity"
  placement_mode      = "custom"
  target_platform     = var.intersight_targetplatform
  iqn_allocation_type = "None"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

resource "intersight_vnic_eth_if" "vNic0" {
  name = "vNic0"

  order = 0
  placement {
    id        = "MLOM"
    switch_id = "A"
    pci_link  = 0
    uplink    = 0
  }

  mac_address_type = "POOL"
  mac_pool {
    moid = intersight_macpool_pool.intersight_macpool_pool_A.moid
  }

  cdn {
    nr_source = "user"
    value     = "vNic0"
  }

  usnic_settings {
    nr_count = 0
    cos      = 5
  }

  vmq_settings {
    enabled = false
    #multi_queue_support    = false
    #num_interrupts         = 16
    #num_sub_vnics          = 64
    #num_vmqs               = 4
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy.moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy.moid
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.fabric_eth_network_control_policy.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy.moid
  }

}

resource "intersight_vnic_eth_if" "vNic1" {
  name = "vNic1"

  order = 1
  placement {
    id        = "MLOM"
    switch_id = "B"
    pci_link  = 0
    uplink    = 0
  }

  mac_address_type = "POOL"
  mac_pool {
    moid = intersight_macpool_pool.intersight_macpool_pool_B.moid
  }

  cdn {
    nr_source = "user"
    value     = "vNic1"
  }

  usnic_settings {
    nr_count = 0
    cos      = 5
  }

  vmq_settings {
    enabled = false
    #multi_queue_support    = false
    #num_interrupts         = 16
    #num_sub_vnics          = 64
    #num_vmqs               = 4
  }

  lan_connectivity_policy {
    moid = intersight_vnic_lan_connectivity_policy.intersight_vnic_lan_connectivity_policy.moid
  }

  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.intersight_vnic_eth_adapter_policy.moid
  }

  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.intersight_fabric_eth_network_group_policy.moid
  }

  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.fabric_eth_network_control_policy.moid
  }

  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.intersight_vnic_eth_qos_policy.moid
  }

}

resource "intersight_vnic_eth_adapter_policy" "intersight_vnic_eth_adapter_policy" {
  name = "${var.env}_EthAdapter"

  interrupt_scaling = false
  advanced_filter   = false

  vxlan_settings {
    enabled = false
  }

  roce_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = false
  }

  arfs_settings {
    enabled = false
  }

  uplink_failback_timeout = 5

  completion_queue_settings {
    nr_count  = 5
    ring_size = 1
  }

  interrupt_settings {
    nr_count        = 8
    coalescing_time = 125
    coalescing_type = "MIN"
    mode            = "MSIx"
  }

  rss_settings = true

  rss_hash_settings {
    ipv4_hash         = true
    ipv6_ext_hash     = false
    ipv6_hash         = true
    tcp_ipv4_hash     = true
    tcp_ipv6_ext_hash = false
    tcp_ipv6_hash     = true
    udp_ipv4_hash     = false
    udp_ipv6_hash     = false
  }

  rx_queue_settings {
    nr_count  = 4
    ring_size = 512
  }

  tx_queue_settings {
    nr_count  = 1
    ring_size = 256
  }

  tcp_offload_settings {
    large_receive = true
    large_send    = true
    rx_checksum   = true
    tx_checksum   = true
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

resource "intersight_fabric_eth_network_group_policy" "intersight_fabric_eth_network_group_policy" {
  name = "${var.env}_EthNetworkGroup"

  vlan_settings {
    object_type   = "vnic.VlanSettings"
    native_vlan   = 1
    allowed_vlans = var.intersight_inbandvlan
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

resource "intersight_fabric_eth_network_control_policy" "fabric_eth_network_control_policy" {
  name        = "${var.env}_EthNetworkControl"
  cdp_enabled = true
  forge_mac    = "allow"
  lldp_settings {
    object_type       = "fabric.LldpSettings"
    receive_enabled  = false
    transmit_enabled = true
  }
  mac_registration_mode = "allVlans"
  uplink_fail_action    = "linkDown"

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

resource "intersight_vnic_eth_qos_policy" "intersight_vnic_eth_qos_policy" {
  name = "${var.env}_EthQoS"

  mtu            = 1500
  rate_limit     = 0
  cos            = 0
  burst          = 10240
  priority       = "Best Effort"
  trust_host_cos = false

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# Create Storage Policy
resource "intersight_storage_storage_policy" "intersight_storage_storage_policy" {
  name = "${var.env}_Storage"

  use_jbod_for_vd_creation = true
  unused_disks_state       = "Jbod"
  default_drive_mode       = "UnconfiguredGood"
  m2_virtual_drive {
    enable          = true
    controller_slot = "MSTOR-RAID-1"
    object_type     = "storage.M2VirtualDriveConfig"
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}