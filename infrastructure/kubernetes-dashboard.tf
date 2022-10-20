// Helm Chart that will be used to create Kubernetes Dashboard
// Not required but useful
resource "helm_release" "k8s_dashboard" {
  name = "kubernetes-dashboard"

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "5.11.0"
  namespace        = "kubernetes-dashboard"
  create_namespace = true
}