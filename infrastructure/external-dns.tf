// Helm Chart that will be used to create External DNS Resources
resource "helm_release" "external_dns" {
  name = "external-dns"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "6.10.2"
  set {
    name  = "provider"
    value = "scaleway"
  }
  set {
    name  = "sources[0]"
    value = "service"
  }
  set {
    name  = "domainFilters[0]"
    value = var.dns_zone
  }
  //External DNS Helm CHart does not seem to read data from secret
  set {
    name  = "scaleway.scwAccessKey"
    value = var.scw_access_key
  }
  set {
    name  = "scaleway.scwSecretKey"
    value = var.scw_secret_key
  }
  set {
    name  = "scaleway.scwDefaultOrganizationId"
    value = var.scw_default_org_id
  }

}