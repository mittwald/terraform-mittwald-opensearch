output "opensearch_url" {
  value = "https://${local.container_name}:${local.container_api_port}"
  description = "The internal URL at which the OpenSearch API endpoint will be available."
}

output "opensearch_dashboard_url" {
  value = vars.opensearch_dashboard_enabled ? "https://${local.dashboard_container_name}:${local.dashboard_web_port}" : null
  description = "The internal URL at which the OpenSearch dashboard will be available."
}

output "opensearch_container_id" {
  value = resource.mittwald_container_stack.opensearch.containers[local.container_name].id
  description = "The ID of the OpenSearch container. This might be useful when wanting to connect a virtualhost to this container for external access."
}

output "opensearch_dashboard_container_id" {
  value = vars.opensearch_dashboard_enabled ? one(resource.mittwald_container_stack.opensearch_dashboard[*].containers[local.dashboard_container_name].id) : null
  description = "The ID of the OpenSearch dashboard container. This might be useful when wanting to connect a virtualhost to this container for external access."
}