
resource "google_notebooks_instance" "notebook" {
  name = "jupyter-instance"
  location = var.zone
  machine_type = "e2-medium"

  container_image {
    repository = "gcr.io/jkjk-339310/cryptobase"
    tag = "main"
  }

  # instance_owners = ["admin@hashicorptest.com"]
  # service_account = "emailAddress:my@service-account.com"

  # install_gpu_driver = true
  data_disk_type = "PD_SSD"
  data_disk_size_gb = 100
  no_remove_data_disk = true

  # no_public_ip = true
  # no_proxy_access = true

  # network = data.google_compute_network.my_network.id
  # subnet = data.google_compute_subnetwork.my_subnetwork.id

  # labels = {
  #   k = "val"
  # }

  metadata = {
    terraform = "true"
  }
}

