# resource "google_cloud_scheduler_job" "cron-ftx-lt" {
#   name        = "cron-ftx-lt"
#   time_zone   = "Asia/Singapore"
#   schedule    = "2 8 * * *"

#   pubsub_target {
#     # topic.id is the topic's full resource name.
#     topic_name = google_pubsub_topic.cron-ftx-lt.id
#     data       = base64encode("test")
#   }
# }

# resource "google_pubsub_topic" "cron-ftx-lt" {
#   name = "cron-ftx-lt"
#   message_retention_duration = "600s"
# }

# resource "null_resource" "cron-zip" {
#   triggers = { on_version_change = "${var.cron-ftx-lt-ver}" }

#   provisioner "local-exec" {
#     command      = "curl -o /tmp/cron-ftx-lt.zip https://codeload.github.com/alienczf/gcp-func-ftx/zip/refs/tags/${var.cron-ftx-lt-ver}"
#   }
#   provisioner "local-exec" { command = "unzip /tmp/cron-ftx-lt.zip" }
#   provisioner "local-exec" { command = "rm /tmp/cron-ftx-lt.zip" }
#   provisioner "local-exec" {
#     when    = destroy
#     command = "rm -rf /tmp/gcp-func-ftx-*"
#     on_failure = continue
#   }
# }

# data "archive_file" "cron-ftx-lt-zip" {
#   type        = "zip"
#   source_dir  = "$/tmp/gcp-func-ftx-${var.cron-ftx-lt-ver}/"
#   output_path = "${path.root}/cron-ftx-lt.zip"
#   depends_on = [null_resource.cron-zip]
# }

# resource "google_storage_bucket_object" "cron-ftx-lt" {
#   # need the hash to ping cloud function to update
#   name   = "cron-ftx-lt.${data.archive_file.cron-ftx-lt-zip.output_md5}.zip"
#   bucket = google_storage_bucket.tmp.name
#   source = "${path.root}/cron-ftx-lt.zip"
#   content_disposition = "attachment"
#   content_encoding    = "gzip"
#   content_type        = "application/zip"
# }

# resource "google_cloudfunctions_function" "cron-ftx-lt" {
#   name        = "ftx-lt"
#   description = "fetch ftx data"
#   runtime     = "python39"

#   available_memory_mb   = 1024
#   source_archive_bucket = google_storage_bucket.tmp.name
#   source_archive_object = google_storage_bucket_object.cron-ftx-lt.name
#   event_trigger {
#     event_type          = "providers/cloud.pubsub/eventTypes/topic.publish"
#     resource            = google_pubsub_topic.cron-ftx-lt.id
#   }
#   entry_point           = "on_pubsub"
#   timeout               = 540

#   ingress_settings      = "ALLOW_ALL"
#   min_instances         = 1
#   max_instances         = 1
# }

# # IAM entry for a single user to invoke the function
# resource "google_cloudfunctions_function_iam_member" "invoker" {
#   project        = google_cloudfunctions_function.cron-ftx-lt.project
#   region         = google_cloudfunctions_function.cron-ftx-lt.region
#   cloud_function = google_cloudfunctions_function.cron-ftx-lt.name

#   role   = "roles/cloudfunctions.invoker"
#   member = "user:alienczf@gmail.com"
# }