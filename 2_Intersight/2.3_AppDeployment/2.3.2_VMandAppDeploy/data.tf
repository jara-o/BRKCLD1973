data "vsphere_datacenter" "TF_datacenter" {
    name = var.env
}
data "vsphere_datastore" "datastore" {
    datacenter_id = data.vsphere_datacenter.TF_datacenter.id
    name = "datastore1"
}
data "vsphere_host" "esxi" {
  name = var.esxi_hostname
  datacenter_id = data.vsphere_datacenter.TF_datacenter.id
}
data "vsphere_distributed_virtual_switch" "vds" {
  name = "vds-01"
  datacenter_id = data.vsphere_datacenter.TF_datacenter.id
}
data "vsphere_network" "dpg" {
  name          = "pg-01-vm-network"
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id
  datacenter_id = data.vsphere_datacenter.TF_datacenter.id
}
data "vsphere_virtual_machine" "template" {
  name          = "/${data.vsphere_datacenter.TF_datacenter.name}/vm/${var.vm_template_folder}/${var.vm_template_name}"
  datacenter_id = data.vsphere_datacenter.TF_datacenter.id
}