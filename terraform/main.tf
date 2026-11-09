locals {
  chart_path = "${path.module}/../chart/server-health-api"
}

resource "kubernetes_namespace_v1" "env" {
  for_each = var.environments

  metadata {
    name = each.value.namespace
    labels = {
      env                            = each.key
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "app" {
  for_each = var.environments

  name      = "server-health-api"
  namespace = kubernetes_namespace_v1.env[each.key].metadata[0].name
  chart     = local.chart_path

  values = [
    file("${local.chart_path}/${each.value.values_file}")
  ]

  wait    = true
  timeout = 120
  atomic  = true
}
