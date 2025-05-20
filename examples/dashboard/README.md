# Dashboard deployment example

This example shows how to use the `mittwald/opensearch/mittwald` module to deploy an OpenSearch dashboard.

To deploy a dashboard instance, set the `opensearch_dashboard_enabled` input variable to true. This example also shows you how to make the dashboard available at a public URL using a `mittwald_virtualhost` resource.

## Enabling the dashboard deployment

Set the `openserach_dashboard_enabled` input variable to `true`, to enable the dashboard deployment:

```hcl
module "opensearch" {
  source = "mittwald/opensearch/mittwald"

  project_id = mittwald_project.test.id
  opensearch_initial_admin_password = random_password.opensearch_admin.result
  opensearch_dashboard_enabled = true
}
```

### Connecting a virtual host

To make the dashboard available from outside your hosting environment, use the `opensearch_dashboard_container_id` to deploy a `mittwald_virtualhost` resource:

```hcl
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
```