resource "linode_lke_cluster" "this" {
  label       = var.cluster_name
  k8s_version = var.k8s_version
  region      = var.region
  tags        = var.tags

  pool {
    type  = var.pool_instance_type
    count = var.pool_instance_count

    dynamic "autoscaler" {
      for_each = var.enable_autoscaler ? [1] : []
      content {
        min = var.autoscaler_min
        max = var.autoscaler_min
      }
    }
  }

  lifecycle {
    ignore_changes = [
      pool.0.count
    ]
  }
}