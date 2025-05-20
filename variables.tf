variable "project_id" {
    type = string
    description = "Project ID in which to start OpenSearch"
}

variable "opensearch_version" {
    type = string
    default = "3"
    description = "OpenSearch version to install; this needs to be a valid tag from https://hub.docker.com/r/opensearchproject/opensearch/tags"
}

variable "initial_admin_password" {
    type = string
    sensitive = true
    description = "Initial admin password to use for OpenSearch. This must be a strong password; see https://opensearch.org/blog/replacing-default-admin-credentials/ for more information."
}

variable "dashboard_enabled" {
    type = bool
    default = false
    description = "Set this flag to enable an OpenSearch dashboard deployment"
}