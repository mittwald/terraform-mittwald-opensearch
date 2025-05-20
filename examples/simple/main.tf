// might also be obtained by creating a mittwald_project resource
variable "project_id" {
  type = string
}

// might also be a sensitive variable
resource "random_password" "opensearch_admin" {
  length  = 16
  special = true
}

module "opensearch" {
  source = "mittwald/opensearch/mittwald"

  project_id = var.project_id
  opensearch_initial_admin_password = random_password.opensearch_admin.result
}