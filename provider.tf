terraform {
  required_providers {
  google = {   
  source = "hashicorp/google"
    version = "~> 4.60.0"
    }
  }
}

provider "google" {
  project = ""
  region = "US-central1-a"
  credentials = "${file("filename.json")}"
}
