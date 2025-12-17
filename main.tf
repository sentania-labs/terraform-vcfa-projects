resource "kubernetes_manifest" "this" {
  manifest = {
    "apiVersion" = "project.cci.vmware.com/v1alpha2"
    "kind"       = "Project"
    "metadata" = {
      "name" = var.project_name
    }
    "spec" = {
      "description" = var.description
    }
  }
}

