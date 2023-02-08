# Create UUID Pool
resource "intersight_uuidpool_pool" "uuidpool_pool" {
  name             = "${var.env}_UUID_Pool"
  assignment_order = "default"
  prefix           = var.intersight_uuidprefix
  uuid_suffix_blocks {
    object_type = "uuidpool.UuidBlock"
    from        = var.intersight_uuidfrom
    size        = var.intersight_uuidsize
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# KVM IP Pool
resource "intersight_ippool_pool" "intersight_ip_pool" {
  name             = "${var.env}_KVM_IP_Pool"
  assignment_order = "sequential"
  ip_v4_config {
    gateway     = var.intersight_kvmdipgw
    netmask     = var.intersight_kvmdipmask
    primary_dns = var.intersight_primarydns
  }
  ip_v4_blocks {
    from = var.intersight_kvmdipfrom
    to   = var.intersight_kvmdipto
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

# MAC Address Pools
resource "intersight_macpool_pool" "intersight_macpool_pool_A" {
  name = "${var.env}_Mac_Pool_A"
  mac_blocks {
    object_type = "macpool.Block"
    from        = var.intersight_macafrom
    to          = var.intersight_macato
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}

resource "intersight_macpool_pool" "intersight_macpool_pool_B" {
  name = "${var.env}_Mac_Pool_B"
  mac_blocks {
    object_type = "macpool.Block"
    from        = var.intersight_macbfrom
    to          = var.intersight_macbto
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.results[0].moid
  }
}