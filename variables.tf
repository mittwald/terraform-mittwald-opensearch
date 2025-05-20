variable "project_id" {
    type = string
    description = "Project ID in which to start OpenSearch"
}

variable "opensearch_version" {
    type = string
    default = "3"
    description = "OpenSearch version to install; this needs to be a valid tag from https://hub.docker.com/r/opensearchproject/opensearch/tags"
}

variable "opensearch_initial_admin_password" {
    type = string
    sensitive = true
    description = "Initial admin password to use for OpenSearch"
}

variable "opensearch_dashboard_enabled" {
    type = bool
    default = false
    description = "Enable an OpenSearch dashboard deployment"
}