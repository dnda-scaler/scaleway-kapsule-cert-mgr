resource "scaleway_k8s_cluster" "clusterk8s" {
  name                        = "clusterk8s-cert-dns-integration"
  version                     = var.kubernetes_version
  cni                         = "cilium"
  delete_additional_resources = true
}

resource "scaleway_k8s_pool" "pool_k8s" {
  cluster_id = scaleway_k8s_cluster.clusterk8s.id
  name       = "pool-cliusterk8s-test"
  node_type  = "DEV1-M"
  size       = 2
}

resource "null_resource" "kubeconfig" {
  depends_on = [scaleway_k8s_pool.pool_k8s] # at least one pool here
  triggers = {
    host                   = scaleway_k8s_cluster.clusterk8s.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.clusterk8s.kubeconfig[0].token
    cluster_ca_certificate = scaleway_k8s_cluster.clusterk8s.kubeconfig[0].cluster_ca_certificate
  }
}


provider "kubernetes" {

  host  = null_resource.kubeconfig.triggers.host
  token = null_resource.kubeconfig.triggers.token
  cluster_ca_certificate = base64decode(
    null_resource.kubeconfig.triggers.cluster_ca_certificate
  )
}
