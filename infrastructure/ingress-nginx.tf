locals {
  application_dns="${var.user_mgt_app_dns}.${var.dns_zone}"
}

//Reserved IP for the Load Balancer of the ingress
resource "scaleway_lb_ip" "nginx_ip" {
  project_id = scaleway_k8s_cluster.clusterk8s.project_id
}
resource "scaleway_domain_record" "www" {
  dns_zone = var.dns_zone
  name     = var.user_mgt_app_dns
  type     = "A"
  data     = scaleway_lb_ip.nginx_ip.ip_address
  ttl      = 300
}

//NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name      = "nginx-ingress"
  namespace = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  create_namespace = true


  //Associate the Load Balancer wiyth an IP (not required as if it is not specified) the controller will create a Flexible IP
  //But it can be useful if we want to keep/reserve the same IP
  set {
    name = "controller.service.loadBalancerIP"
    value = scaleway_lb_ip.nginx_ip.ip_address
  }

  set {
    name  = "controller.config.whitelist-source-range"
    value = join(",", var.allowed_cidr)
  }

  // enable proxy protocol to get client ip addr instead of loadbalancer one
  set {
    name  = "controller.config.use-proxy-protocol"
    value = "true"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-proxy-protocol-v2"
    value = "true"
  }

  // indicates in which zone to create the loadbalancer
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-zone"
    value = var.scaleway_zone
  }

  // enable to avoid node forwarding
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  // External DNS Annotation , to know which DNS Record must be created
  // and attached to this IP
  /**
* External DNS for scaleway provider is still in beta so we will use terraform to create the record 
* and attach it to the Load Balancer IP
**/
  /*set {
    name  = "controller.service.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = local.application_dns
  }*/


  // enable only this annotation if you plan to use cert-manager see docs for more details
  // https://www.scaleway.com/en/docs/compute/kubernetes/api-cli/using-load-balancer-annotations/#service.beta.kubernetes.ioscw-loadbalancer-use-hostname
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-use-hostname"
    value = "true"
  }
}