// Configure the Google Cloud provider

variable "region" {
  description = "Google Cloud region"
  default     = "europe-west2"
}

variable "project" {
  description = "Google Cloud Project Name"
  default     = "my-project-name"
}

variable "credentials_file" {
  description = "Google Cloud Credentials json file"
  default     = "credentials.json"
}

variable "env" {
  description = "Project environment"
  default     = "dev"
}

variable "cost_centre" {
  description = "Project Cost Centre"
  default     = "costly"
}

variable "thisproject" {
  description = "Project Name"
  default     = "projectly"
}

variable "alias" {
  description = "Project Alias"
  default     = "bobbins"
}


locals {
  project_labels = {
    "env"         = var.env
    "alias"       = var.alias
    "cost_centre" = var.cost_centre
    "project"     = var.thisproject
    "gcp_project" = var.project
  }
}

variable "project_lifecycle" {
  description = "Project lifecycle (future production environment can be in development)"
  default     = "live"
}

variable "argo_version" {
  description = "Helm Chart version for ArgoCD"
  default     = "3.35.4"
}

variable "argo_workflows_version" {
  description = "Helm Chart version for ArgoCD"
  default     = "0.41.1"
}

variable "argocd_enabled" {
  description = "ArgoCD enabled"
  type        = bool
  default     = false
}

variable "argoworkflows_enabled" {
  description = "Argo Workflows enabled"
  type        = bool
  default     = false
}

