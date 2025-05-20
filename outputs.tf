output "opensearch_url" {
  value = "https://${local.container_name}:${local.container_api_port}"
}

output "opensearch_dashboard_url" {
  value = "https://${local.dashboard_container_name}:${local.dashboard_web_port}"
}

output "opensearch_container_id" {
  value = resource.mittwald_container_stack.opensearch.containers[local.container_name].id
}

output "opensearch_dashboard_container_id" {
  value = one(resource.mittwald_container_stack.opensearch_dashboard[*].containers[local.dashboard_container_name].id)
}