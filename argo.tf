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
    google_container_cluster.primary
  ]
}

resource "helm_release" "rollouts" {
  count            = var.argorollouts_enabled ? 1 : 0
  name             = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argo"
  create_namespace = true
  version          = var.argo_rollouts_version
  values           = [file("helm/argo/argo-rollouts-values.yaml")]
  depends_on = [
    google_container_cluster.primary
  ]
}

resource "helm_release" "events" {
  count            = var.argoevents_enabled ? 1 : 0
  name             = "argo-events"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-events"
  namespace        = "argo-events"
  create_namespace = true
  version          = var.argo_events_version
  values           = [file("helm/argo/argo-events-values.yaml")]
  depends_on = [
    google_container_cluster.primary
  ]
}

