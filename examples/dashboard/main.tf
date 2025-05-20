resource "random_password" "opensearch_admin" {
  length  = 16
  special = true
}

resource "mittwald_project" "test" {
  server_id = "..."
}

module "opensearch" {
  source = "mittwald/opensearch"

  project_id = mittwald_project.test.id
  opensearch_initial_admin_password = random_password.opensearch_admin.result
  opensearch_dashboard_enabled = true
}

resource "mittwald_virtualhost" "dashboard" {
  hostname   = "opensearch.${mittwald_project.test.short_id}.project.space"
  project_id = mittwald_project.test.id

  paths = {
    "/" = {
      container = {
        container_id = module.opensearch.opensearch_dashboard_container_id
        port         = "5601/tcp"
      }
    }
  }
}