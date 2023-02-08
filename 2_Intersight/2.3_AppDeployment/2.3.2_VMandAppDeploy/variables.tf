variable "env" {
  type = string
}
variable "vsphere_user" {
  type = string
}
variable "vsphere_password" {
  type = string
}
variable "vsphere_server" {
  type = string
}
variable "esxi_hostname" {
  type = string
}
variable "esxi_username" {
  type = string
}
variable "esxi_password" {
  type = string
}
variable "ubuntu_hostname" {
  type = string
}
variable "ubuntu_username" {
  type = string
}
variable "ubuntu_password" {
  type = string
}
variable "vm_template_folder" {
  type = string
}
variable "vm_template_name" {
  type = string
}
variable "remoteexec_script" {
  type = string
}
variable "ubuntu_netmask" {
  type = number
}
variable "ubuntu_gateway" {
  type = string
}
variable "github_repo_url" {
  type = string
}