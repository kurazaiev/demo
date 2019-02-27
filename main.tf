provider "google" {
  credentials = "${file("./creds/firstproject-230011-9ae6ccc7a21c.json")}"
  project = "firstproject-230011"
  region = "europe-west1"
}

resource "google_container_cluster" "primary" {
  name = "k8s-cluster"
  zone = "europe-west1-d"
  remove_default_node_pool = true
  initial_node_count = 1
  #logging_service = "logging.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary_pool" {
  name = "primary-pool"
  cluster = "${google_container_cluster.primary.name}"
  zone = "europe-west1-d"
  version = "1.11.7-gke.6"
  node_count = "2"

  node_config {
    machine_type = "n1-standard-1"
    image_type = "GCI"
    disk_size_gb = 20
  }
  management {
    auto_repair = true
    auto_upgrade = true
  }
  autoscaling {
    min_node_count = 3
    max_node_count = 5
  }
}
