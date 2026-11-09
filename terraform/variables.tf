variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the cluster"
  type        = string
  default     = "~/.kube/config"
}

variable "environments" {
  description = "Environments to deploy: namespace and Helm values file for each"
  type = map(object({
    namespace   = string
    values_file = string
  }))
  default = {
    dev = {
      namespace   = "sha-dev"
      values_file = "values-dev.yaml"
    }
    prod = {
      namespace   = "sha-prod"
      values_file = "values-prod.yaml"
    }
  }
}
