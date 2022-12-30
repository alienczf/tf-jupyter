
resource "google_notebooks_instance" "notebook" {
  name = "jupyter-instance"
  location = var.zone
  machine_type = "n1-standard-1"

  container_image {
    repository = "gcr.io/jkjk-339310/cryptobase"
    tag = "main"
  }

  # install_gpu_driver = true
  data_disk_type = "PD_SSD"
  data_disk_size_gb = 100
  no_remove_data_disk = true

  metadata = {
    terraform = "true"
  }
}

