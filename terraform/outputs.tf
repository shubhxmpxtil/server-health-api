output "namespaces" {
  description = "Namespace per environment"
  value       = { for k, ns in kubernetes_namespace_v1.env : k => ns.metadata[0].name }
}

output "release_status" {
  description = "Helm release status per environment"
  value       = { for k, r in helm_release.app : k => r.status }
}
