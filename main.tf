#Project 

# VPC
provider "google" {
  version = "3.5.0"
  credentials = file("/downloads/instance.json")
  project = ""
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
