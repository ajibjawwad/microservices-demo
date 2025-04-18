# resource "helm_release" "vault" {
#   name       = "vault"
#   repository = "https://helm.releases.hashicorp.com"
#   chart      = "vault"
#   namespace  = "vault"
#   set {
#     name = "server.dev.enabled"
#     value = "true"
#   }
#   set {
#     name = "ui.enabeld"
#     value = "true"
#   }
# }