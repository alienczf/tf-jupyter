resource "google_storage_bucket" "tmp" {
  name          = "jkjk-bucket-tmp"
  location      = "US"
  force_destroy = true
  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket" "bucket" {
  name     = "jkjk-bucket"
  location = "US"
}

resource "google_bigquery_dataset" "FTX" {
  project                     = "${var.project_id}"
  dataset_id                  = "FTX"
  friendly_name               = "FTX"
  location                    = "US"
}
