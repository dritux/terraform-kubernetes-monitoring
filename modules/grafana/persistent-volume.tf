resource "kubernetes_persistent_volume_claim" "pvc" {

  metadata {
    name = "grafana-pvc"
    namespace = var.monitoring_name_space
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.grafana_persistent_volume_claim_storage
      }
    }
    volume_name = kubernetes_persistent_volume.pv.metadata.0.name
  }
}

resource "kubernetes_persistent_volume" "pv" {
  metadata {
    name = "grafana-pv"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.app.name
        fs_type = "ext4"
      }
    }
    storage_class_name = "standard"
  }
}

resource "google_compute_disk" "app" {
  name = "grafana-disk"
  type = "pd-standard"
  zone = "southamerica-east1-b"
  size = "5"
  labels = {
    environment = "production"
  }
}