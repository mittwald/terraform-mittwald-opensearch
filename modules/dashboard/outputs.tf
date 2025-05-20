output "url" {
  value = "https://${local.container_name}:${local.container_web_port}"
  description = "The internal URL at which the OpenSearch dashboard will be available."
}

output "container_id" {
  value = one(resource.mittwald_container_stack.opensearch_dashboard[*].containers[local.container_name].id)
  description = "The ID of the OpenSearch dashboard container. This might be useful when wanting to connect a virtualhost to this container for external access."
}