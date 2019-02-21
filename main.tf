provider "google" {
  credentials = "${file("firstproject-230011-9ae6ccc7a21c.json")}"
  project = "firstproject-230011"
  region = "europe-west1-d"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name = "k8s-cluster"
  zone = "europe-west1-d"
  cluster = "k8s-cluster"
  node_count = 3

  node_config {
    machine_type = "custom-1-1024"
    image_type = "GCI"
    disk_size_gb = 20
    network = "default"
    enable-cloud-logging = true
    autoscaling = {
      min_node_count = 3
      max_node-count = 5
    }
    cluster-version = "1.11.6-gke.2"
    monitoring_service = "none"
  }
}
/*

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
*/
