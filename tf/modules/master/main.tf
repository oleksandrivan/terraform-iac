resource "google_compute_instance" "k8s-master" {
  project      = local.project_id
  zone         = "${local.region}-a"
  name         = "k8s-master"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20240315a"
    }
  }

  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false
  }


  metadata_startup_script = file("${path.module}/master-startup.sh")

  network_interface {
    network = "default"
    access_config {}
  }
}
