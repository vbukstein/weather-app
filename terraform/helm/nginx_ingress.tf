resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.10.1"
  namespace  = "ingress-nginx"
  create_namespace = true
  values = [
    <<-EOF
    controller:
      service:
        annotations:
          service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
          service.beta.kubernetes.io/aws-load-balancer-internal: "true"
          service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: "8000"
        type: LoadBalancer
    EOF
  ]
}
