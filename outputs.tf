output "opensearch_url" {
  value = "https://${local.container_name}:${local.container_api_port}"
}

output "opensearch_dashboard_url" {
  value = vars.opensearch_dashboard_enabled ? "https://${local.dashboard_container_name}:${local.dashboard_web_port}" : null
}

output "opensearch_container_id" {
  value = resource.mittwald_container_stack.opensearch.containers[local.container_name].id
}

output "opensearch_dashboard_container_id" {
  value = vars.opensearch_dashboard_enabled ? one(resource.mittwald_container_stack.opensearch_dashboard[*].containers[local.dashboard_container_name].id) : null
}