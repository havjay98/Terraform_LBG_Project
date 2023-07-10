terraform {
  required_providers {
  google = {   
  source = "hashicorp/google"
    version = "~> 1.5.2"
    }
  }
}

provider "google" {
  project = ""
  region = "US-central1-a"
  credentials = "${file("filename.json")}"
}
