resource "helm_release" "argocd" {
  count            = var.argocd_enabled ? 1 : 0
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = var.argo_version
  values           = [file("helm/argo/argocd-values.yaml")]
  depends_on = [
    google_container_cluster.primary
  ]
}

resource "helm_release" "workflows" {
  count            = var.argoworkflows_enabled ? 1 : 0
  name             = "argo-workflows"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-workflows"
  namespace        = "argo"
  create_namespace = true
  version          = var.argo_workflows_version
  values           = [file("helm/argo/argo-workflows-values.yaml")]
  depends_on = [
    helm_release.argocd
  ]
}

