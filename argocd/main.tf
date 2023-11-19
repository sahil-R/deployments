provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "gke_river-messenger-400308_europe-north1_primary"
}



variable "keypath" {
  type = string
}
variable "project" {
  type=string
}
variable "region" {
  type = string
}

variable "zone" {
  type = string
}

provider "google" {
    credentials = var.keypath 
    project = var.project
    region  = var.region
    zone    = var.zone
}

# resource "kubernetes_manifest" "argocd-configmap-namespace" {
#   manifest = {
#     apiVersion = "v1"
#     kind = "Namespace"
#     metadata = {
#         name = "argocd"
#     }
#   }
# }

# resource "kubernetes_manifest" "argocd-configmap-deployment" {
#   manifest = {
#     apiVersion ="apps/v1"
#     kind = "Deployment"
#     metadata = {
#         name = "argocd-server"
#         namespace = "argocd"
#     }
#     spec = {
#         replicas="3"
#         template={
#             metadata={
#                 labels={
#                     app="argo-server"
#                 }
#             }
#             spec = {
#                 containers = {
#                     name = "argocd-server"
#                     image = "argoproj/argocd:latest"
#                 }
#             }
#         }
#     }
#   }
# }

# # resource "kubernetes_manifest" "argocd" {
# #     manifest = kubernetes_manifest.argocd-configmap-namespace
# # }

# resource "kubernetes_namespace" "argocd" {  
#   metadata {
#     name = "argocd"
#   }
# }

resource "helm_release" "argocd-server" {
  name = "argocd-server"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.24.1"
  namespace  = "argocd"
  # depends_on = [
  #   kubernetes_namespace.argocd
  # ]
}