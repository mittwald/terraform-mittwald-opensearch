terraform {
  required_providers {
    mittwald = {
      source = "mittwald/mittwald"
      version = "~> 1.0.0"
    }
  }
}

locals {
    container_name = "opensearch"
    container_api_port = 9200
    container_analyzer_port = 9600

    dashboard_container_name = "opensearch-dashboard"
    dashboard_web_port = 5601

    volume_data_name = "opensearch-data"
}

data "mittwald_container_image" "opensearch" {
  image = "opensearchproject/opensearch:${var.opensearch_version}"
}

data "mittwald_container_image" "opensearch_dashboard" {
  image = "opensearchproject/opensearch-dashboards:${var.opensearch_version}"
}

resource "mittwald_container_stack" "opensearch" {
  project_id = var.project_id
  default_stack = true

  containers = {
    (local.container_name) = {
      image = data.mittwald_container_image.opensearch.image
      description = "OpenSearch"
      ports = [
        {
          container_port = local.container_api_port
          public_port = local.container_api_port
          protocol = "tcp"
        },
        {
          container_port = local.container_analyzer_port
          public_port = local.container_analyzer_port
          protocol = "tcp"
        }
      ]

      entrypoint = data.mittwald_container_image.opensearch.entrypoint
      command = data.mittwald_container_image.opensearch.command

      environment = {
        "discovery.type" = "single-node"
        "OPENSEARCH_INITIAL_ADMIN_PASSWORD" = var.opensearch_initial_admin_password
      }

      volumes = [
        {
          volume = local.volume_data_name
          mount_path = "/usr/share/opensearch/data"
        }
      ]
    }
  }

  volumes = {
    (local.volume_data_name) = {}
  }
}

resource "mittwald_container_stack" "opensearch_dashboard" {
  count = var.opensearch_dashboard_enabled ? 1 : 0
  depends_on = [mittwald_container_stack.opensearch]

  project_id = var.project_id
  default_stack = true

  containers = {
    (local.dashboard_container_name) = {
      image = data.mittwald_container_image.opensearch_dashboard.image
      description = "OpenSearch Dashboard"
      ports = [
        {
          container_port = local.dashboard_web_port
          public_port = local.dashboard_web_port
          protocol = "tcp"
        }
      ]

      entrypoint = data.mittwald_container_image.opensearch_dashboard.entrypoint
      command = data.mittwald_container_image.opensearch_dashboard.command

      environment = {
        "opensearch_security.auth.type" = "basicauth"
        "opensearch_security.auth.multiple_auth_enabled" = "true"
        "OPENSEARCH_HOSTS" = jsonencode([
          "https://${local.container_name}:${local.container_api_port}"
        ])
      }
    }
  }
}