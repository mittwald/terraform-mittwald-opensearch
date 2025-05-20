# Simple usage example

This example shows a minimal usage of the `mittwald/opensearch/mittwald` module.

It will provision a single-node OpenSearch instance in a container, which will then be available for internal use in your hosting environment. To connect to your OpenSearch instance, use the `module.opensearch.url` output variable.

```hcl
module "opensearch" {
  source = "mittwald/opensearch/mittwald"

  project_id = var.project_id
  initial_admin_password = "..."
}
```

## Generating a random initial admin password

Starting with OpenSearch 2.12, each instance must be provided with a secure initial admin password ([read more](https://opensearch.org/blog/replacing-default-admin-credentials/)). You can use the `random_password` resource to generate a random password that fulfills the password requirements:

```hcl
resource "random_password" "opensearch_admin" {
  length  = 16
  special = true
}

module "opensearch" {
  source = "mittwald/opensearch/mittwald"

  project_id = var.project_id
  initial_admin_password = random_password.opensearch_admin.result
}
```