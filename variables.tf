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
  description = "Helm Chart version for Argo Workflows"
  default     = "0.41.1"
}

variable "argo_rollouts_version" {
  description = "Helm Chart version for Argo Rollouts"
  default     = "2.35.1"
}

variable "argo_events_version" {
  description = "Helm Chart version for Argo Events"
  default     = "2.4.4"
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

variable "argorollouts_enabled" {
  description = "Argo Rollouts enabled"
  type        = bool
  default     = false
}

variable "argoevents_enabled" {
  description = "Argo Events enabled"
  type        = bool
  default     = false
}

