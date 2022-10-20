resource "local_file" "kube_config" {
  content  = scaleway_k8s_cluster.clusterk8s.kubeconfig[0].config_file
  filename = pathexpand(var.kube_config_output)
}

output "load_balancer_ip" {
  value = scaleway_lb_ip.nginx_ip.ip_address
}

output "application_dns" {
  value = local.application_dns
}