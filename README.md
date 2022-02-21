# Learn Terraform - Provision a GKE Cluster

1. install google cloud sdk: https://cloud.google.com/sdk/docs/quickstart
2. run `gcloud init`
3. run `gcloud auth application-default login` 
3. install kubectl: kubernetes-cli
4. install terraform
5. run terraform init
6. run terraform apply
7. setup kubectl `gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)`