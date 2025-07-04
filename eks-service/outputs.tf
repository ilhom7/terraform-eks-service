output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "load_balancer_hostname" {
  value = kubernetes_service.app.status[0].load_balancer[0].ingress[0].hostname
}
