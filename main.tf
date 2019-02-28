provider "google" {
  credentials = "35f976aa-d0e3-40f8-a602-9300fc85a3d0"
  project = "firstproject-230011"
  region = "europe-west1"
}

resource "google_container_cluster" "k8s-cluster" {
  name = "k8s-cluster"
  zone = "europe-west1-d"
  remove_default_node_pool = true
  min_master_version = "1.11.7-gke.6"
  initial_node_count = 1
  network = "${google_compute_network.k8s-network.name}"
  subnetwork = "${google_compute_subnetwork.k8s-subnetwork.name}"
}

resource "google_compute_network" "k8s-network" {
  name = "k8s-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-subnetwork" {
  name = "k8s-subnetwork"
  ip_cidr_range = "10.10.10.0/24"
  network = "k8s-network"
  region = "europe-west1"
}

resource "google_container_node_pool" "k8s-pool" {
  name = "k8s-pool"
  cluster = "${google_container_cluster.k8s-cluster.name}"
  zone = "europe-west1-d"
  version = "1.11.7-gke.6"
  node_count = "2"
  #machine_type = "n1-standard-1"
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
