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

    volume_data_name = "opensearch-data"

    url = "https://${local.container_name}:${local.container_api_port}"
}

data "mittwald_container_image" "opensearch" {
  image = "opensearchproject/opensearch:${var.opensearch_version}"
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
        "OPENSEARCH_INITIAL_ADMIN_PASSWORD" = var.initial_admin_password
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

module "dashboard" {
  source = "./modules/dashboard"

  count      = var.dashboard_enabled ? 1 : 0
  depends_on = [mittwald_container_stack.opensearch]

  project_id         = var.project_id
  opensearch_urls    = [local.url]
  opensearch_version = var.opensearch_version
}

moved {
  from = mittwald_container_stack.opensearch_dashboard[0]
  to   = module.dashboard[0].mittwald_container_stack.opensearch_dashboard
}