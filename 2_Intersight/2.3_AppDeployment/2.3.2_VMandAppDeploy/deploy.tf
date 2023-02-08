# create VM based on template and install sample app
resource "vsphere_virtual_machine" "vm" {
  name             = "${var.env}-SampleApp"
  resource_pool_id = data.vsphere_host.esxi.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  network_interface {
    network_id   = data.vsphere_virtual_machine.template.network_interfaces[0]["network_id"] #data.vsphere_virtual_machine.dpg.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.env}-SampleApp"
        domain    = var.env
      }
      network_interface {
        ipv4_address = var.ubuntu_hostname
        ipv4_netmask = var.ubuntu_netmask
      }
      ipv4_gateway = var.ubuntu_gateway
    }
  }

 connection {
    type     = "ssh"
    user     = var.ubuntu_username
    password = var.ubuntu_password
    host     = var.ubuntu_hostname
  }
  provisioner "remote-exec" {
    script = var.remoteexec_script
  }

}