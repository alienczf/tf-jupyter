output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

# output "notebook_uri" {
#   value       = google_notebooks_instance.notebook.proxy_uri
#   description = "uri to access notebook"
# }

# output "notebook_id" {
#   value       = google_notebooks_instance.notebook.id
#   description = "notebook id"
# }

# output "notebook_state" {
#   value       = google_notebooks_instance.notebook.state
#   description = "notebook state"
# }

# output "notebook_create_time" {
#   value       = google_notebooks_instance.notebook.create_time
#   description = "notebook create time"
# }

# output "notebook_update_time" {
#   value       = google_notebooks_instance.notebook.update_time
#   description = "notebook update time"
# }