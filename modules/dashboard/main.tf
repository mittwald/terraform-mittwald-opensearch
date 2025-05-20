terraform {
  required_providers {
    mittwald = {
      source = "mittwald/mittwald"
      version = "~> 1.0.0"
    }
  }
}

locals {
    container_name = "opensearch-dashboard"
    container_web_port = 5601
}

data "mittwald_container_image" "opensearch_dashboard" {
  image = "opensearchproject/opensearch-dashboards:${var.opensearch_version}"
}

resource "mittwald_container_stack" "opensearch_dashboard" {
  project_id = var.project_id
  default_stack = true

  containers = {
    (local.container_name) = {
      image = data.mittwald_container_image.opensearch_dashboard.image
      description = "OpenSearch Dashboard"
      ports = [
        {
          container_port = local.container_web_port
          public_port    = local.container_web_port
          protocol       = "tcp"
        }
      ]

      entrypoint = data.mittwald_container_image.opensearch_dashboard.entrypoint
      command    = data.mittwald_container_image.opensearch_dashboard.command

      environment = {
        "opensearch_security.auth.type" = "basicauth"
        "opensearch_security.auth.multiple_auth_enabled" = "true"
        "OPENSEARCH_HOSTS" = jsonencode(var.opensearch_urls)
      }
    }
  }
}