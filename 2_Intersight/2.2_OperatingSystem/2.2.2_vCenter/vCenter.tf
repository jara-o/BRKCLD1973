# create a new datacenter
resource "vsphere_datacenter" "datacenter" {
  name = "${var.env}"
}

# create a folder for templates in that datacenter
resource "vsphere_folder" "folder" {
  path = "Templates"
  type = "vm"
  datacenter_id = data.vsphere_datacenter.datacenter.id

  depends_on = [vsphere_datacenter.datacenter]
}

# add standalone host to new datacenter
resource "vsphere_host" "esx-01" {
  hostname = var.esxi_hostname
  username = var.esxi_username
  password = var.esxi_password
  datacenter = data.vsphere_datacenter.datacenter.id
  thumbprint = data.vsphere_host_thumbprint.thumbprint.id

  depends_on = [vsphere_datacenter.datacenter]

}

# create distributed virtual switch
resource "vsphere_distributed_virtual_switch" "vds" {
  name          = var.vds_name
  datacenter_id = data.vsphere_datacenter.datacenter.id

  host {
    host_system_id = data.vsphere_host.esxi.id
    devices        = [var.vds_vmnic]
  }

  uplinks         = ["uplink1"]
  active_uplinks  = ["uplink1"]
  standby_uplinks = []
}

# create distributed port group
resource "vsphere_distributed_port_group" "pg-01-vm-network" {
  name                            = var.dpg_name
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds.id
  vlan_id                         = var.dpg_vlanid
}