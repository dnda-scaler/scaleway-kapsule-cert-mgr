variable "kubernetes_version" {
  type=string
  default = "1.24.5"
  description = "The targeted Kubernetes version"
}
variable "dns_zone" {
  type=string
  description = "Scaleway DNS Zone name"
}
variable "scaleway_region" {
  type=string
}
variable "scaleway_zone" {
  type=string
}
variable "scw_access_key" {
  type=string
}
variable "scw_secret_key" {
  type=string
}
variable "scw_default_org_id" {
  type=string
}
variable "user_mgt_app_dns" {
  type=string
  default = "user-management"
}
