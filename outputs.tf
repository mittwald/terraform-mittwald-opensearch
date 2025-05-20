output "url" {
  value = local.url
  description = "The internal URL at which the OpenSearch API endpoint will be available."
}

output "container_id" {
  value = resource.mittwald_container_stack.opensearch.containers[local.container_name].id
  description = "The ID of the OpenSearch container. This might be useful when wanting to connect a virtualhost to this container for external access."
}

output "dashboard_url" {
  value = var.dashboard_enabled ? one(module.dashboard[*].url) : null
  description = "The internal URL at which the OpenSearch dashboard will be available."
}

output "dashboard_container_id" {
  value = var.dashboard_enabled ? one(module.dashboard[*].container_id) : null
  description = "The ID of the OpenSearch dashboard container. This might be useful when wanting to connect a virtualhost to this container for external access."
}