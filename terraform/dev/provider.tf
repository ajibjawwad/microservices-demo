provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # or your kubeconfig path
  }
}
