variable "intersight_organization" {
  type = string
}
variable "intersight_apikey" {
  type        = string
  description = "The path to your secretkey for Intersight OR the your secret key as a string"
}
variable "intersight_secretkey" {
  type        = string
  description = "Default Password"
}
variable "intersight_servers" {
  type = string
}
variable "os_config_file_name" {
  type = string
}
variable "os_repo_name" {
  type = string
}
variable "os_repo_nr_version" {
  type = string
}
variable "os_repo_vendor" {
  type = string
}
variable "os_repo_source_os_iso_path" {
  type = string
}
variable "scu_repo_name" {
  type = string
}
variable "scu_nr_version" {
  type = string
}
variable "scu_supported_models" {
  type = list
}
variable "repo_source_scu_iso_path" {
  type = string
}
variable "os_hostname" {
  type        = string
}
variable "os_ip_config_type" {
  type        = string
}
variable "os_ipv4_addr" {
  type        = string
}
variable "os_ipv4_netmask" {
  type        = string
}
variable "os_ipv4_gateway" {
  type        = string
}
variable "os_ipv4_dns_ip" {
  type        = string
}
variable "os_root_password" {
  type        = string
}
variable "os_vlanid" {
  type        = number
}
variable "os_answers_nr_source" {
  type        = string
  default     = "Template"
}