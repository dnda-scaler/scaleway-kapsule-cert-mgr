resource "local_file" "kube_config" {
  content  = scaleway_k8s_cluster.clusterk8s.kubeconfig[0].config_file
  filename = pathexpand(var.kube_config_output)
}