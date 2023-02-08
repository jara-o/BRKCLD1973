data "vsphere_datacenter" "datacenter" {
    name = var.env
    depends_on = [vsphere_datacenter.datacenter]
} 

data "vsphere_host_thumbprint" "thumbprint" {
  address = var.esxi_hostname
  insecure = true
}

data "vsphere_host" "esxi" {
  name = var.esxi_hostname
  datacenter_id = data.vsphere_datacenter.datacenter.id
  depends_on = [vsphere_host.esx-01]
}