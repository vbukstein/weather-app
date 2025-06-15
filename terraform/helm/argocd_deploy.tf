resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.0.15" # Use the latest stable version

  namespace         = "argocd"
  create_namespace  = true
  values = [
    <<-EOF
    server:
        ingress:
            # -- Enable an ingress resource for the Argo CD server
            enabled: true
            ingressClassName: "nginx"
            path: /argocd
            extraRules:
                - http:
                    paths:
                    - path: /argocd
                      pathType: Prefix
                      backend:
                        service:
                            name: '{{ include "argo-cd.server.fullname" . }}'
                            port:
                                name: '{{ .Values.server.service.servicePortHttpsName }}'
        extraArgs: 
        - '--insecure'
        - '--rootpath=/argocd'
    crds:
        keep: false
    EOF
  ]
}
