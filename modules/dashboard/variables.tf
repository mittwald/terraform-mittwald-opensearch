variable "project_id" {
    type = string
    description = "Project ID in which to start OpenSearch"
}

variable "opensearch_version" {
    type = string
    default = "3"
    description = "OpenSearch version to install; this needs to be a valid tag from https://hub.docker.com/r/opensearchproject/opensearch/tags"
}

variable "opensearch_urls" {
  type = list(string)
  description = "URLs at which the OpenSearch backens are available"
}