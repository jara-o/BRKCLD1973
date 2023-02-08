variable "env" {
  type        = string
}
variable "intersight_apikey" {
  type        = string
}
variable "intersight_secretkey" {
  type        = string
}
variable "intersight_organization" {
  type        = string
  default     = "default"
}
variable "intersight_targetplatform" {
  type        = string
}
variable "intersight_uuidprefix" {
  type        = string
}
variable "intersight_uuidfrom" {
  type        = string
}
variable "intersight_uuidsize" {
  type        = number
}
variable "intersight_inbandvlan" {
  type        = number
}
variable "intersight_kvmdipgw" {
  type        = string
}
variable "intersight_kvmdipmask" {
  type        = string
}
variable "intersight_primarydns" {
  type        = string
}
variable "intersight_kvmdipfrom" {
  type        = string
}
variable "intersight_kvmdipto" {
  type        = string
}
variable "intersight_macafrom" {
  type        = string
}
variable "intersight_macato" {
  type        = string
}
variable "intersight_macbfrom" {
  type        = string
}
variable "intersight_macbto" {
  type        = string
}
variable "intersight_servers" {
  type        = list
}