#Project 

# VPC
provider "google" {
  credentials = file("/downloads/instance.json")
  project = "playground-s-11-98574d2b"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_subnetwork" "public-subnetwork" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
  }


# A user-managed Vertex AI Notebook.


# A Private Googl cloud storage bucket with a retention policy


# A BigQuery dataset (empty or with sample data) which includes a configured optimisation that could speed up queires).
